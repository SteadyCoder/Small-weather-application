//
//  SWInternetConnectionChecked.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/27/19.
//  Copyright © 2019 steady. All rights reserved.
//

import UIKit

/// Class responsible for checking internet connection repeatedly.
class SWInternetConnectionChecked: NSObject {
    
    /// Class method that activates internet connection checker. Internet connection is checked every 0.2 seconds.
    ///
    /// - Parameter checkInternetStatusCompletion: the status of internet connection check.
    class func internetConnectionCheckerRun(checkInternetStatusCompletion: @escaping (_ status: Bool) -> Void) {
        let timer = Timer(timeInterval: 0.2, repeats: true) { (timer) in
            checkInternetStatusCompletion(SWReachability.isConnectedToNetwork())
        }
        RunLoop.main.add(timer, forMode: .default)
    }
}
