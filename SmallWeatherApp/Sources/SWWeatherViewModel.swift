//
//  SWWeatherViewModel.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/26/19.
//  Copyright © 2019 steady. All rights reserved.
//

import UIKit

class SWWeatherViewModel: NSObject {
    var listOfCitiesName: [String] = ["Kiev", "London", "Toronto"]
    
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
            SWRequestManager.shared.getWeather(withCityName: self.listOfCitiesName[index], completion: { (city, success, error) in
                if success, let city = city {
                    _ = city.managedObjectContext?.saveContext()
                }
                
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
