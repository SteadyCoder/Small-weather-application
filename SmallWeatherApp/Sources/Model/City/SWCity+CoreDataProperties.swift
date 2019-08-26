//
//  SWCity+CoreDataProperties.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/26/19.
//  Copyright © 2019 steady. All rights reserved.
//
//

import Foundation
import CoreData


extension SWCity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SWCity> {
        return NSFetchRequest<SWCity>(entityName: "City")
    }

    @NSManaged public var id: String?
    @NSManaged public var weather: SWWeather?
    @NSManaged public var info: SWMainWeatherInfo?

}
