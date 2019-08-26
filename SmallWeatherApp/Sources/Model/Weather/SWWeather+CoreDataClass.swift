//
//  SWWeather+CoreDataClass.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/26/19.
//  Copyright © 2019 steady. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(SWWeather)
public class SWWeather: NSManagedObject, Decodable {
    public required convenience init(from decoder: Decoder) throws {
        self.init(context: SWModelManager.shared.model.viewContext)
        
        let container = try decoder.container(keyedBy: SWWeather.CodingKeys.self)
        
        do {
            let id = try container.decode(Int.self, forKey: .id)
            self.id = "\(id)"
            self.mainDescription = try container.decodeIfPresent(String.self, forKey: .main)
            self.detailDescription = try container.decodeIfPresent(String.self, forKey: .description)
            self.iconId = try container.decodeIfPresent(String.self, forKey: .iconId)
        } catch {
            print("Decode \(SWWeather.self) error \(error)")
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case description = "description"
        case iconId = "icon"
    }
    
    var image: UIImage? {
        guard let imageData = iconImage as Data? else {
            return nil
        }
        return UIImage(data: imageData)
    }
    
    func downloadIconImage(withContext context: NSManagedObjectContext, loadCompletion: (() -> Void)? = nil) {
        guard let iconId = self.iconId else {
            return
        }
        SWRequestManager.shared.getIconImage(withIconId: iconId, withImageFormat: .x2png) { [weak self] (data, success, error) in
            if success, let imageData = data {
                self?.iconImage = imageData as NSData
                if let completion = loadCompletion {
                    completion()
                }
            }
        }
    }
}
