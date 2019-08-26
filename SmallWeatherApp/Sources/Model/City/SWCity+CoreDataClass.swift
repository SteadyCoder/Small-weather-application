//
//  SWCity+CoreDataClass.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/26/19.
//  Copyright © 2019 steady. All rights reserved.
//
//

import Foundation
import CoreData


public class SWCity: NSManagedObject, Decodable {
    public required convenience init(from decoder: Decoder) throws {
        self.init(context: SWModelManager.shared.model.viewContext)
        
        let container = try decoder.container(keyedBy: SKCoupon.CodingKeys.self)
        
        do {
            self.discounter = try container.decodeIfPresent(SKDiscounter.self, forKey: .discounter)
        } catch {
            print("Decode coupon error \(error)")
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case weather = "weather"
        case main = "main"
        case couponBalance = "icon"
    }
}
