//
//  SWWeather+CoreDataProperties.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/26/19.
//  Copyright © 2019 steady. All rights reserved.
//
//

import Foundation
import CoreData


extension SWWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SWWeather> {
        return NSFetchRequest<SWWeather>(entityName: "Weather")
    }

    @NSManaged public var detailDescription: String?
    @NSManaged public var iconId: String?
    @NSManaged public var id: String?
    @NSManaged public var mainDescription: String?
    @NSManaged public var iconImage: NSData?

}
