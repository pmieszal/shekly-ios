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
    
    public var hashValue: Int {
        return id?.hashValue ?? 0
    }
    
    public let id: String?
    public let created: Date?
    
    public var properties: DatabaseModelProperties {
        return DatabaseModelProperties(id: id, created: created)
    }
    
    init(properties: DatabaseModelProperties?) {
        self.id = properties?.id
        self.created = properties?.created
    }
    
    required init(entity: TDatabaseEntity) {
        self.id = entity.id
        self.created = entity.created
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
