//
//  SWRequestManager.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/26/19.
//  Copyright © 2019 steady. All rights reserved.
//

import UIKit

protocol SWRestAPI: class {
    func getWeather(withCityName cityName: String)
}

class SWRequestManager: SWRestAPI {
    func getWeather(withCityName cityName: String) {
        
    }
}
