//
//  SWRequestManager.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/26/19.
//  Copyright © 2019 steady. All rights reserved.
//

import UIKit

enum ImageFormat: String {
    case x1png = "@1x"
    case x2png = "@2x"
    case x3png = "@3x"
}

protocol SWRestAPI: class {
    typealias BaseCompletion = (_ success: Bool, _ error: Error?) -> Void
    typealias FullCompletion = (_ jsonResponse: [String: Any]?, _ success: Bool, _ responseCode: Int?, _ error: NSError?) -> Void
    
    typealias WeatherCompletion = (_ city: [String: Any]?, _ success: Bool, _ errorMessage: String?, _ error: Error?) -> Void
    func getWeather(withCityName cityName: String, completion: WeatherCompletion?)
    
    typealias IconImageCompletion = (_ imageData: Data?, _ success: Bool, _ error: Error?) -> Void
    func getIconImage(withIconId iconId: String, withImageFormat imageFormat: ImageFormat,  completion: IconImageCompletion?)
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
                        compl(js, true, nil, nil)
                    } else {
                        compl(nil, false, json?.description, nil)
                    }
                } else {
                    compl(nil, false, json?.description, nil)
                }
            }
        }.resume()
    }
    
    func getIconImage(withIconId iconId: String, withImageFormat imageFormat: ImageFormat = ImageFormat.x2png, completion: IconImageCompletion?) {
        let url = SWApiRoutes.Weather.iconImage.urlComponents.url!.appendingPathComponent(iconId + imageFormat.rawValue).appendingPathExtension("png")
        session.downloadTask(with: url) { (tempUrl, response, error) in
            if let compl = completion {
                if let error = error {
                    compl(nil, false, error)
                } else if let url = tempUrl, let data = try? Data(contentsOf: url) {
                    compl(data, true, nil)
                } else {
                    compl(nil, false, nil)
                }
            }
        }.resume()
    }
}
