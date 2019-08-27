//
//  SWInternetConnectionChecked.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/27/19.
//  Copyright © 2019 steady. All rights reserved.
//

import UIKit

class SWInternetConnectionChecked: NSObject {
    class func internetConnectionCheckerRun(checkInternetStatusCompletion: @escaping (_ status: Bool) -> Void) {
        let timer = Timer(timeInterval: 0.2, repeats: true) { (timer) in
            checkInternetStatusCompletion(SWReachability.isConnectedToNetwork())
        }
        RunLoop.main.add(timer, forMode: .default)
    }
}
