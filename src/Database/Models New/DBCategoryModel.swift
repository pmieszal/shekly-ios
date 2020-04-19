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
//    let subcategories = LinkingObjects(fromType: DBSubcategoryModel.self, property: "category")
//    let entries = LinkingObjects(fromType: DBWalletEntryModel.self, property: "category")
    
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
}

extension CategoryModel {
    init(_ category: DBCategoryModel) {
        self.init(
            id: category.id,
            name: category.name,
            wallet: WalletModel(category.wallet.first),
            subcategories: []) // category.subcategories.map(SubcategoryModel.init))
    }
    
    init?(_ category: DBCategoryModel?) {
        guard let category = category else {
            return nil
        }
        
        self.init(category)
    }
}
