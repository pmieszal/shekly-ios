//
//  SheklyDatabasePersistance.swift
//  Shared
//
//  Created by Patryk Mieszała on 03/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import CoreData

protocol SheklyDatabaseStore: AnyObject {
    var viewContext: NSManagedObjectContext { get }
    
    func saveContext()
    func managedObjectID(forURIRepresentation url: URL) -> NSManagedObjectID?
}

class SheklyDatabasePersistance: SheklyDatabaseStore {
    
    // MARK: - Core Data stack
    var viewContext: NSManagedObjectContext {
        let context = persistentContainer.viewContext
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        
        return persistentContainer.viewContext
    }
    
    let persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        
        let container = SheklyPresistentContainer(name: "Shekly")
        
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.
                // You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                //TODO: get rid of fatalError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.
                // You should not use this function in a shipping application, although it may be useful during development.
                //TODO: get rid of fatalError
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func managedObjectID(forURIRepresentation url: URL) -> NSManagedObjectID? {
        return persistentContainer.persistentStoreCoordinator.managedObjectID(forURIRepresentation: url)
    }
}
