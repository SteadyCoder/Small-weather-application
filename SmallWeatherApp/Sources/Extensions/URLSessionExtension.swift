//
//  URLSessionExtension.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/26/19.
//  Copyright © 2019 steady. All rights reserved.
//

import Foundation

extension URLSession {
    func dataTask(withURLRequest urlRequest: URLRequest, completion: @escaping SWRestAPI.FullCompletion) -> URLSessionDataTask {
        return self.dataTask(with: urlRequest) { (data, urlResponse, error) in
            print("Response \(String(describing: urlResponse))")
            if let localData = data {
                var json: [String: Any]? = nil
                do {
                    json = try JSONSerialization.jsonObject(with: localData, options: .allowFragments) as? [String: Any]
                } catch {
                    print("data serialization error on \(String(describing: urlResponse?.url))")
                }
                
                let response = urlResponse as? HTTPURLResponse
                if response?.statusCode == 200 {
                    completion(json, true, response?.statusCode, nil)
                } else {
                    completion(json, false, response?.statusCode, error as NSError?)
                }
            } else {
                completion(nil, false, urlResponse?.httpUrlResponse?.statusCode, error as NSError?)
            }
        }
    }
}

extension URLResponse {
    var httpUrlResponse: HTTPURLResponse? {
        return self as? HTTPURLResponse
    }
}
