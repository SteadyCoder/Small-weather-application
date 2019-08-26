//
//  SWSystemInfo+CoreDataProperties.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/26/19.
//  Copyright © 2019 steady. All rights reserved.
//
//

import Foundation
import CoreData


extension SWSystemInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SWSystemInfo> {
        return NSFetchRequest<SWSystemInfo>(entityName: "SystemInfo")
    }

    @NSManaged public var id: String?
    @NSManaged public var type: Int32

}
