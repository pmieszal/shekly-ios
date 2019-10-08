//
//  DatabaseEntity+CoreDataClass.swift
//  Database
//
//  Created by Patryk Mieszała on 13/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation
import CoreData

protocol ConfigurableEntity {
    
    func set<TModel: DatabaseEntry>(withModel model: TModel)
}

@objc(DatabaseEntity)
public class DatabaseEntity: NSManagedObject, ConfigurableEntity {
    
    var properties: DatabaseModelProperties {
        return DatabaseModelProperties(id: id, created: created)
    }
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.id = UUID().uuidString
        self.created = Date()
    }
    
    func set<TModel>(withModel model: TModel) where TModel : DatabaseEntry {
        preconditionFailure("Override in subclass")
    }
    
    class func fetchRequest<TEntity: DatabaseEntity>(forId id: String) -> NSFetchRequest<TEntity> {
        let request: NSFetchRequest<NSFetchRequestResult> = TEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        
        return request as! NSFetchRequest<TEntity>
    }
    
}

