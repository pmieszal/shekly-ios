//
//  DBGroup.swift
//  Database
//
//  Created by Patryk Mieszała on 19/04/2020.
//

import RealmSwift

class DBGroup<TObject: DBModel> {
    let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func get(id: String?) -> TObject? {
        guard let id = id else {
            return nil
        }
        
        return get(id: id)
    }
    
    func get(id: String) -> TObject? {
        let object = realm.object(ofType: TObject.self, forPrimaryKey: id)
        
        return object
    }
    
    func list(filter: NSPredicate = NSPredicate(value: true)) -> [TObject] {
        let objects = realm.objects(TObject.self).filter(filter)
        
        return Array(objects)
    }
    
    func save(object: TObject) {
        execute(transaction: { (realm) in
            realm.add(object, update: .modified)
        })
    }
    
    func remove(object: TObject) {
        execute(transaction: { (realm) in
            guard let objectToDelete = realm.object(
                ofType: TObject.self,
                forPrimaryKey: object.id) else {
                    assertionFailure("No record found")
                    return
            }
            
            realm.delete(objectToDelete)
        })
    }
}

extension DBGroup {
    func execute(transaction: ((Realm) -> ())) {
        do {
            try realm.write {
                transaction(realm)
            }
        } catch {
            assertionFailure("Fix your code")
            print(error)
        }
    }
}
