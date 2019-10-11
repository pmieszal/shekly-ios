//
//  DatabaseEntry.swift
//  Database
//
//  Created by Patryk Mieszała on 13/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import CoreData

protocol DatabaseEntry: AnyObject, Hashable {
    
    associatedtype TEntity: DatabaseEntity
    
    var id: String? { get }
    var created: Date? { get }
    
    init(entity: TEntity)
    
    func set(withEntity entity: TEntity)
    func manageConnectionsAndSave(forEntity entity: TEntity, inContext context: NSManagedObjectContext) throws -> TEntity
}
