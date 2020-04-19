//
//  DBGroup.swift
//  Database
//
//  Created by Patryk Mieszała on 19/04/2020.
//

import RealmSwift

class DBGroup<TObject: DBModel> {
    let realm: Realm
    
    required init(realm: Realm) {
        self.realm = realm
    }
    
    func get(id: String) -> TObject? {
        do {
            let realm = try Realm()
            let object = realm.object(ofType: TObject.self, forPrimaryKey: id)
            
            return object
        } catch {
            assertionFailure("Fix your code")
            print(error)
            
            return nil
        }
    }
    
    func list(filter: NSPredicate = NSPredicate(value: true)) -> [TObject] {
        do {
            let realm = try Realm()
            let objects = realm.objects(TObject.self).filter(filter)
            
            return Array(objects)
        } catch {
            assertionFailure("Fix your code")
            print(error)
            
            return []
        }
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
            let realm = try Realm()
            
            try realm.write {
                transaction(realm)
            }
        } catch {
            assertionFailure("Fix your code")
            print(error)
        }
    }
}
