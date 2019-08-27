//
//  FileManagerExtension.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/26/19.
//  Copyright © 2019 steady. All rights reserved.
//

import Foundation

extension FileManager {
    func moveDownloadFileToTemporaryDirectory(withSourceUrl url: URL) -> URL? {
        let newUrl = URL(fileURLWithPath: NSTemporaryDirectory() + UUID().uuidString + ".png")
        do {
            try self.moveItem(at: url, to: newUrl)
        } catch {
            return nil
        }
        return newUrl
    }
}
