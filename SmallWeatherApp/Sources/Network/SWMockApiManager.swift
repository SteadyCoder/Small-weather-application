//
//  SWMockApiManager.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/26/19.
//  Copyright © 2019 steady. All rights reserved.
//

import UIKit

class SWMockApiManager: SWRestAPI {
    func getWeather(withCityName cityName: String, completion: WeatherCompletion?) {
        let testResponseData =
        """
        {
            "coord": {
                "lon": -0.13,
                "lat": 51.51
            },
            "weather": [
            {
                "id": 800,
                "main": "Clear",
                "description": "clear sky",
                "icon": "01d"
            }
            ],
            "base": "stations",
            "main": {
                "temp": 304.66,
                "pressure": 1016,
                "humidity": 31,
                "temp_min": 302.15,
                "temp_max": 307.04
            },
            "visibility": 10000,
            "wind": {
                "speed": 3.6,
                "deg": 200
            },
            "clouds": {
                "all": 0
            },
            "dt": 1566830640,
            "sys": {
                "type": 1,
                "id": 1414,
                "message": 0.0113,
                "country": "GB",
                "sunrise": 1566795785,
                "sunset": 1566846134
            },
            "timezone": 3600,
            "id": 2643743,
            "name": "London",
            "cod": 200
        }
        """
        
        if let compl = completion {
            if let data = testResponseData.data(using: .utf8), let city = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                compl(city, true, nil, nil)
            } else {
                compl(nil, false, "Bad request", nil)
            }
        }
    }
    
    func getIconImage(withIconId: String = "10d", withImageFormat: ImageFormat = ImageFormat.x2png, completion: IconImageCompletion?) {
        if let compl = completion {
            let image = #imageLiteral(resourceName: "location")
            compl(image.pngData(), true, nil)
        }
    }
}
