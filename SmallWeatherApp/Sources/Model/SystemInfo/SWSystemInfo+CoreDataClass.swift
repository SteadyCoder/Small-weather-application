//
//  SWSystemInfo+CoreDataClass.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/26/19.
//  Copyright © 2019 steady. All rights reserved.
//
//

import Foundation
import CoreData

@objc(SWSystemInfo)
public class SWSystemInfo: NSManagedObject, Decodable {
    public required convenience init(from decoder: Decoder) throws {
        self.init(context: SWModelManager.shared.model.viewContext)
        
        let container = try decoder.container(keyedBy: SWSystemInfo.CodingKeys.self)
        
        do {
            self.id = try container.decode(Int32.self, forKey: .id)
            self.type = try container.decodeIfPresent(Int32.self, forKey: .type) ?? 0
            self.country = try container.decodeIfPresent(String.self, forKey: .country)
        } catch {
            print("Decode \(SWSystemInfo.self) error \(error)")
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case country = "country"
    }
}
