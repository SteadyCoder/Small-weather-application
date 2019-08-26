//
//  JsonExtension.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/26/19.
//  Copyright © 2019 steady. All rights reserved.
//

import Foundation

extension Data {
    var json: [String: Any]? {
        return try? JSONSerialization.jsonObject(with: self) as? [String : Any]
    }
}

extension Dictionary where Key: StringProtocol, Value: Any {
    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: self)
    }
}
