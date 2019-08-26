//
//  SWMainWeatherInfo+CoreDataProperties.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/26/19.
//  Copyright © 2019 steady. All rights reserved.
//
//

import Foundation
import CoreData


extension SWMainWeatherInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SWMainWeatherInfo> {
        return NSFetchRequest<SWMainWeatherInfo>(entityName: "MainWeatherInfo")
    }

    @NSManaged public var tempreture: Double

}
