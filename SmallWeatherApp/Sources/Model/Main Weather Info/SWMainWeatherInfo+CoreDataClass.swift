//
//  SWMainWeatherInfo+CoreDataClass.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/26/19.
//  Copyright © 2019 steady. All rights reserved.
//
//

import Foundation
import CoreData

@objc(SWMainWeatherInfo)
public class SWMainWeatherInfo: NSManagedObject, Decodable {
    public required convenience init(from decoder: Decoder) throws {
        self.init(context: SWModelManager.shared.model.viewContext)
        
        let container = try decoder.container(keyedBy: SWMainWeatherInfo.CodingKeys.self)
        
        do {
            self.tempreture = try container.decodeIfPresent(Double.self, forKey: .tempreture) ?? 0
        } catch {
            print("Decode \(SWMainWeatherInfo.self) error \(error)")
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case tempreture = "temp"
    }
    
    var celciusTempreture: String {
        let celsiusTemp = self.tempreture - 273.15
        return String(format: "%.0f", celsiusTemp)
    }
}
