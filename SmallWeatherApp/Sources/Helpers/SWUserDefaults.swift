//
//  SWUserDefaults.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/27/19.
//  Copyright © 2019 steady. All rights reserved.
//

import UIKit

class SWUserDefaults: NSObject {
    static let shared = SWUserDefaults()
    
    private static let lastUpdateTimeKey = "lastUpdateTime"
    
    var lastUpdateTime: Date? {
        get {
            return UserDefaults.standard.object(forKey: SWUserDefaults.lastUpdateTimeKey) as? Date
        } set (newTime) {
            UserDefaults.standard.set(newTime, forKey: SWUserDefaults.lastUpdateTimeKey)
        }
    }
}
