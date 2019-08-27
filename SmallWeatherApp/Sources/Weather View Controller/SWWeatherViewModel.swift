//
//  SWWeatherViewModel.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/26/19.
//  Copyright © 2019 steady. All rights reserved.
//

import UIKit

protocol SWWeatherViewModelDelegate: AnyObject {
    func loadOfCity(successful: Bool)
}

class SWWeatherViewModel: NSObject {
    var listOfCitiesName: [String] = ["Kiev", "London", "Toronto"]
    weak var delegate: SWWeatherViewModelDelegate?
    
    /// Constructor for view model.
    ///
    /// - Parameter citiesName: the list of cities to load. If you pass nil here the load method will use default list of cities.
    init(withCitiesNames citiesName: [String]? = nil) {
        if let names = citiesName {
            self.listOfCitiesName = names
        }
    }
    
    func loadCitiesData(loadCompletion: (() -> Void)? = nil) {
        // line initates to use this queue in concurrent looping
        let _ = DispatchQueue.global(qos: .userInitiated)
        let dispatchGroup = DispatchGroup()
        
        DispatchQueue.concurrentPerform(iterations: listOfCitiesName.count) { (index) in
            dispatchGroup.enter()
            SWRequestManager.shared.getWeather(withCityName: self.listOfCitiesName[index], completion: { [weak self] (cityJson, success, errorMessage, error) in
                let context = SWModelManager.shared.model.viewContext
                
                if success, let city = cityJson, let cityId = city[SWCity.CodingKeys.id.rawValue] as? Int,
                    let oldCity = SWCity.fetchCity(withContext: context, withCityId: cityId),
                    let cityData = city.jsonData,
                    let newCity = try? JSONDecoder().decode(SWCity.self, from: cityData)
                {
                    context.delete(oldCity)
                    _ = newCity.managedObjectContext?.saveContext()
                } else if success, let cityData = cityJson?.jsonData {
                    let newCity = try? JSONDecoder().decode(SWCity.self, from: cityData)
                    _ = newCity?.managedObjectContext?.saveContext()
                }
                self?.delegate?.loadOfCity(successful: success)
                dispatchGroup.leave()
            })
        }
        dispatchGroup.notify(queue: .main) {
            if let completion = loadCompletion {
                completion()
            }
        }
    }
}
