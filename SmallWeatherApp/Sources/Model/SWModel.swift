//
//  SKModelController.swift
//  Skidka71
//
//  Created by Ivan Tkachenko on 5/4/19.
//  Copyright © 2019 yorich. All rights reserved.
//

import UIKit
import CoreData

class SWModel: NSObject {
    static let skidka71ModelName = "SmallWeatherApp"
    
    let modelName: String
    
    init(aModelName modelName: String, completionClosure: (() -> ())? = nil) {
        //This resource is the same name as your xcdatamodeld contained in your project
        self.modelName = modelName
        guard let modelURL = Bundle.main.url(forResource: modelName, withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        
        self.viewContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        self.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        self.viewContext.persistentStoreCoordinator = psc
        
        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated)
        queue.async {
            guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
                fatalError("Unable to resolve document directory")
            }
            let storeURL = docURL.appendingPathComponent(modelName + ".sqlite")
            do {
                try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true])
                if let closure = completionClosure {
                    closure()
                }
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }
    }
    
    // MARK: - Core Data Saving support
    var viewContext: NSManagedObjectContext
}

extension NSManagedObjectContext {
    func saveContext() -> Bool {
        do {
            try self.save()
        } catch {
            debugPrint("Failure on saving context: \(error) \(error.localizedDescription)")
            return false
        }
        return true
    }
}
