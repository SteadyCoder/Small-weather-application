//
//  SWModelManager.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 5/27/19.
//  Copyright © 2019 steady. All rights reserved.
//

import UIKit

/// Class responsible for managing core data model layer.
class SWModelManager: NSObject {
    static let shared = SWModelManager()
    
    private override init () { super.init() }
    
    var model: SWModel!
}
