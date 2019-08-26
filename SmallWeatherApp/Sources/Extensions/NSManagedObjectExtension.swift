//
//  NSManagedObjectExtension.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/26/19.
//  Copyright © 2019 steady. All rights reserved.
//

import CoreData

extension NSManagedObject {
    
    class func fetchAll(inContext context: NSManagedObjectContext, withPredicate predicate: NSPredicate? = nil, withSortDescriptor sortDescriptors: [NSSortDescriptor]? = nil, includeSubentities: Bool = false) -> [NSFetchRequestResult]? {
        let request = self.fetchRequest()
        
        request.includesSubentities = includeSubentities
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
        var result: [NSFetchRequestResult]? = nil
        do {
            result = try context.fetch(request)
        } catch {
            print("Fetch request error: \(error.localizedDescription)")
        }
        
        return result
    }
    
    class func fetchFirst(inContext context: NSManagedObjectContext, withPredicate predicate: NSPredicate? = nil, withSortDescriptor sortDescriptors: [NSSortDescriptor]? = nil, includeSubentities: Bool = false) -> NSFetchRequestResult? {
        return fetchAll(inContext: context, withPredicate: predicate, withSortDescriptor: sortDescriptors, includeSubentities: includeSubentities)?.first
    }
    
    class func countOfObjects(inContext context: NSManagedObjectContext, withPredicate predicate: NSPredicate? = nil, includeSubentities: Bool = false) -> Int {
        let request = self.fetchRequest()
        
        request.includesSubentities = includeSubentities
        request.predicate = predicate
        
        var resultAmount = 0
        do {
            resultAmount = try context.count(for: request)
        } catch {
            print("Count fetch request error: \(error.localizedDescription)")
        }
        return resultAmount
    }
    
    class func deleteAllData(entity: String) {
        let managedContext = SWModelManager.shared.model.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
    
    class func deleteAllDataWithAllEntities() {
        if let name = SWCity.entity().name {
            deleteAllData(entity: name)
        }
        
        if let name = SWWeather.entity().name {
            deleteAllData(entity: name)
        }
        
        if let name = SWSystemInfo.entity().name {
            deleteAllData(entity: name)
        }
        
        
        if let name = SWMainWeatherInfo.entity().name {
            deleteAllData(entity: name)
        }
    }
    
}

