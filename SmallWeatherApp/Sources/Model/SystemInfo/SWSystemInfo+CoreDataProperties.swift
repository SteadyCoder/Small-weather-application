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

    @NSManaged public var id: Int32
    @NSManaged public var type: Int32
    @NSManaged public var country: String?

}
