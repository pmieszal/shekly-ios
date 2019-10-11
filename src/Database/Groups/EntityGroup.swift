//
//  EntityGroup.swift
//  Database
//
//  Created by Patryk Mieszała on 08/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation
import CoreData

import Shared

class EntityGroup<TModel: DatabaseEntry> {
    
    typealias Entity = TModel.TEntity
    typealias Model = TModel
    
    let store: SheklyDatabaseStore
    
    init(store: SheklyDatabaseStore) {
        self.store = store
    }
    
    @discardableResult
    func save(model: Model) -> Model {
        let context: NSManagedObjectContext = store.viewContext
        
        do {
            var entity: Entity
            
            if let id = model.id, let fetchedEntity: Entity = self.entity(byId: id) {
                entity = fetchedEntity
            }
            else {
                entity = Entity(context: context)
            }
            
            entity.set(withModel: model)
            
            let entitySaved = try model.manageConnectionsAndSave(forEntity: entity, inContext: context)
            let savedModel = Model(entity: entitySaved)
            
            return savedModel
        }
        catch let error {
            log.error(error)
            
            return model
        }
    }
    
    func delete(model: Model) -> Bool {
        guard let id = model.id, let fetchedEntity: Entity = entity(byId: id) else { return false }
        
        let context: NSManagedObjectContext = store.viewContext
        context.delete(fetchedEntity)
        
        do {
            try context.save()
            
            return true
        }
        catch let error {
            log.error(error)
            
            return false
        }
    }
    
    func list() -> [Model] {
        let request: NSFetchRequest<NSFetchRequestResult> = Entity.fetchRequest()
        
        return execute(request: request as! NSFetchRequest<Entity>)
    }
    
    func entity(byId id: String) -> Entity? {
        let request = Entity.fetchRequest(forId: id)
        
        do {
            let result: [Entity] = try store.viewContext.fetch(request) as! [Entity]
            
            return result.first
        }
        catch let error {
            log.error(error)
            
            return nil
        }
    }
    
    func execute(request: NSFetchRequest<Entity>) -> [Model] {
        do {
            let result: [Entity] = try store.viewContext.fetch(request)
            
            let mapped: [Model] = result
                .map { entity -> Model in
                    let model: Model = Model(entity: entity)
                    
                    return model
            }
            
            return mapped
        }
        catch let error {
            log.error(error)
            
            return []
        }
    }
}
