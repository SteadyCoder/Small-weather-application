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
    var urlComponents: URLComponents { get }
    var method: HTTPMethod { get }
}

/// Class responsible for urls and other constatns related to rest api.
class SWApiRoutes: NSObject {
    private static let apiToken = "91c38bb9e9409896a7d89912d9eb56fd"
    private static let apiTokenQueryKey = "appid"
    static let cityRequestParameterKey = "q"
    
    static let scheme = "https"
    static let host = "api.openweathermap.org"
    static let imageHost = "openweathermap.org"
    
    enum Weather: SWApiBase {
        case city
        case iconImage
        
        static var baseUrl: URL {
            get {
                return URL(string: scheme + host)!
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .city:
                return .GET
            case .iconImage:
                return .GET
            }
        }
        
        var urlComponents: URLComponents {
            var urlComponents = URLComponents()
            urlComponents.scheme = SWApiRoutes.scheme
            switch self {
            case .city:
                urlComponents.host = SWApiRoutes.host
                urlComponents.queryItems = [URLQueryItem(name: SWApiRoutes.apiTokenQueryKey, value: SWApiRoutes.apiToken)]
                urlComponents.path = self.path
            case .iconImage:
                urlComponents.host = SWApiRoutes.imageHost
                urlComponents.path = self.path
            }
            return urlComponents
        }
        
        func url(with queryParams: [String: String]) -> URL {
            var urlComponents = self.urlComponents
            urlComponents.setQueryItems(with: queryParams)
            return urlComponents.url!
        }
        
        var path: String {
            switch self {
            case .city:
                return "/data/2.5/weather"
            case .iconImage:
                return "/img/wn"
            }
        }
    }
    
}

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        if self.queryItems != nil {
            parameters.forEach({ self.queryItems?.append(URLQueryItem(name: $0.key, value: $0.value)) })
        } else {
            self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
    }
}
