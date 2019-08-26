//
//  SWCity+CoreDataClass.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/26/19.
//  Copyright © 2019 steady. All rights reserved.
//
//

import Foundation
import CoreData

@objc(SWCity)
public class SWCity: NSManagedObject, Decodable {
    public required convenience init(from decoder: Decoder) throws {
        self.init(context: SWModelManager.shared.model.viewContext)
        
        let container = try decoder.container(keyedBy: SWCity.CodingKeys.self)
        
        do {
            self.id = try container.decode(Int64.self, forKey: .id)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            if let weatherList = try container.decodeIfPresent([SWWeather].self, forKey: .weatherInfo) {
                if let weather = weatherList.first {
                    self.weather = weather
                }
            }
            self.info = try container.decodeIfPresent(SWMainWeatherInfo.self, forKey: .mainInfo)
            self.systemInfo = try container.decodeIfPresent(SWSystemInfo.self, forKey: .systemInfo)
        } catch {
            print("Decode \(SWCity.self) error \(error)")
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case weatherInfo = "weather"
        case systemInfo = "sys"
        case mainInfo = "main"
    }
    
    class func fetchCity(withContext context: NSManagedObjectContext, withCityId cityId: Int) -> SWCity? {
        return SWCity.fetchFirst(inContext: context, withPredicate: NSPredicate(format: "id == %i", cityId), withSortDescriptor: nil, includeSubentities: true) as? SWCity
    }
}
