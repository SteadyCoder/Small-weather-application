//
//  SWRequestManager.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/26/19.
//  Copyright © 2019 steady. All rights reserved.
//

import UIKit

protocol SWRestAPI: class {
    typealias BaseCompletion = (_ success: Bool, _ error: Error?) -> Void
    typealias FullCompletion = (_ jsonResponse: [String: Any]?, _ success: Bool, _ responseCode: Int?, _ error: NSError?) -> Void
    
    typealias WeatherCompletion = (_ city: SWCity?, _ success: Bool, _ errorMessage: String?, _ error: Error?) -> Void
    func getWeather(withCityName cityName: String, completion: WeatherCompletion?)
}

class SWRequestManager: SWRestAPI {
    static let shared: SWRestAPI = SWRequestManager()
    
    
    private var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        
        configuration.timeoutIntervalForRequest  = 15
        configuration.timeoutIntervalForResource = 15
        
        return URLSession(configuration: configuration)
    }()
    
    func getWeather(withCityName cityName: String, completion: WeatherCompletion? = nil) {
        let url = SWApiRoutes.Weather.city.url(with: ["q": cityName])
        
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 15)
        urlRequest.httpMethod = SWApiRoutes.Weather.city.method.rawValue
        
        session.dataTask(withURLRequest: urlRequest) { (json, success, code, error) in
            if let compl = completion {
                if let error = error {
                    compl(nil, false, json?.description, error)
                } else if success {
                    if let js = json {
                        if let data = try? JSONSerialization.data(withJSONObject: js),
                            let city = try? JSONDecoder().decode(SWCity.self, from: data) {
                            compl(city, true, nil, nil)
                        } else {
                            print("Error message \(js)")
                            compl(nil, false, js.description, nil)
                        }
                    } else {
                        compl(nil, false, json?.description, nil)
                    }
                } else {
                    compl(nil, false, json?.description, nil)
                }
            }
        }.resume()
    }
}
