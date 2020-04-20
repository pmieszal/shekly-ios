//
//  DBCategoryModel.swift
//  Database
//
//  Created by Patryk Mieszała on 19/04/2020.
//

import RealmSwift
import Domain

class DBCategoryModel: DBModel {
    @objc dynamic var name = ""
    let wallet = LinkingObjects(fromType: DBWalletModel.self, property: "categories")
    let subcategories = List<DBSubcategoryModel>()
    let entries = List<DBWalletEntryModel>()
    
    convenience init(_ category: CategoryModel) {
        self.init()
        id = category.id ?? NSUUID().uuidString
        name = category.name
    }
    
    convenience init?(_ category: CategoryModel?) {
        guard let category = category else {
            return nil
        }
        
        self.init(category)
    }
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}

extension CategoryModel {
    init(_ category: DBCategoryModel) {
        self.init(
            id: category.id,
            name: category.name,
            wallet: SimplyWalletModel(category.wallet.first),
            subcategories: category.subcategories.map(SimplySubcategoryModel.init))
    }
    
    init?(_ category: DBCategoryModel?) {
        guard let category = category else {
            return nil
        }
        
        self.init(category)
    }
}
