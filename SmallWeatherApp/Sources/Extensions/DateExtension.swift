//
//  DateExtension.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/27/19.
//  Copyright © 2019 steady. All rights reserved.
//

import Foundation

extension Date {
    var toTimeString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        dateFormatter.locale = Locale.autoupdatingCurrent// init(identifier: "en_GB")
        
        return dateFormatter.string(from: self)
    }
}
