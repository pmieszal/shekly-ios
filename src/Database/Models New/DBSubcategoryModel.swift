//
//  DBSubcategoryModel.swift
//  Database
//
//  Created by Patryk Mieszała on 19/04/2020.
//

import RealmSwift
import Domain

class DBSubcategoryModel: DBModel {
    @objc dynamic var name = ""
    let wallet = LinkingObjects(fromType: DBWalletModel.self, property: "subcategories")
    let category = LinkingObjects(fromType: DBCategoryModel.self, property: "subcategories")
    let entries = List<DBWalletEntryModel>()
    
    convenience init(_ subcategory: SubcategoryModel) {
        self.init()
        id = subcategory.id ?? NSUUID().uuidString
        name = subcategory.name
    }
    
    convenience init?(_ subcategory: SubcategoryModel?) {
        guard let subcategory = subcategory else {
            return nil
        }
        
        self.init(subcategory)
    }
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}

extension SubcategoryModel {
    init(_ subcategory: DBSubcategoryModel) {
        self.init(
            id: subcategory.id,
            name: subcategory.name,
            wallet: SimplyWalletModel(subcategory.wallet.first),
            category: SimplyCategoryModel(subcategory.category.first))
    }
    
    init?(_ subcategory: DBSubcategoryModel?) {
        guard let subcategory = subcategory else {
            return nil
        }
        
        self.init(subcategory)
    }
}
