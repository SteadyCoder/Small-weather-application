//
//  SWApiRoutes.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/26/19.
//  Copyright © 2019 steady. All rights reserved.
//

import UIKit

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
}

protocol SWApiBase {
    static var baseUrl: URL { get }
    var url: URL { get }
    var method: HTTPMethod { get }
}

class SWApiRoutes: NSObject {
    static let apiToken = "a1d1dc41d71e2b1c1d329e64770bf088"
    
    static let host = "api.openweathermap.org/data/2.5/"
    
    enum Weather: SWApiBase {
        static var baseUrl: URL {
            get {
                return URL(string: host + "weather")!
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .city:
                return .GET
            }
        }
        
        case city
        
        var url: URL {
            switch self {
            case .city:
                return Weather.baseUrl
            }
        }
    }
    
}
