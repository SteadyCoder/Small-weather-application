//
//  SWModelManager.swift
//  Skidka71
//
//  Created by Ivan Tkachenko on 5/27/19.
//  Copyright © 2019 yorich. All rights reserved.
//

import UIKit

class SWModelManager: NSObject {
    static let shared = SWModelManager()
    
    private override init () { super.init() }
    
    var model: SWModel!
}
