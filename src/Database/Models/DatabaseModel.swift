//
//  DatabaseModel.swift
//  Database
//
//  Created by Patryk Mieszała on 13/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import CoreData

public class DatabaseModel<TDatabaseEntity: DatabaseEntity>: DatabaseEntry {
    
    typealias TEntity = TDatabaseEntity
    
    public let id: String?
    public let created: Date?
    
    public var properties: DatabaseModelProperties {
        return DatabaseModelProperties(id: id, created: created)
    }
    
    init(properties: DatabaseModelProperties?) {
        id = properties?.id
        created = properties?.created
    }
    
    required init(entity: TDatabaseEntity) {
        id = entity.id
        created = entity.created
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id?.hashValue ?? 0)
    }
    
    func set(withEntity entity: TEntity) {
        preconditionFailure("Override in subclass")
    }
    
    func manageConnectionsAndSave(forEntity entity: TEntity, inContext context: NSManagedObjectContext) throws -> TEntity {
        //Override this in subclass when needed
        try context.save()
        
        return entity
    }
}

public func == <TDatabaseEntity: DatabaseEntity>(lhs: DatabaseModel<TDatabaseEntity>, rhs: DatabaseModel<TDatabaseEntity>) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
