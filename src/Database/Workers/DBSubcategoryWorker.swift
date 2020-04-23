//
//  DBSubcategoryWorker.swift
//  Database
//
//  Created by Patryk Mieszała on 19/04/2020.
//

import Domain
import RealmSwift

class DBSubcategoryWorker: DBGroup<DBSubcategoryModel> {
    let walletWorker: DBWalletWorker
    let categoryWorker: DBCategoryWorker
    
    init(realm: Realm,
         walletWorker: DBWalletWorker,
         categoryWorker: DBCategoryWorker) {
        self.walletWorker = walletWorker
        self.categoryWorker = categoryWorker
        super.init(realm: realm)
    }
    
    func getSubcategories(forCategory category: CategoryModel) -> [SubcategoryModel] {
        guard let categoryId = category.id else {
            return []
        }
        
        return getSubcategories(forCategoryId: categoryId)
    }
    
    func save(subcategory: SubcategoryModel) -> SubcategoryModel {
        let dbEntry = DBSubcategoryModel(subcategory)
        
        let dbWallet = walletWorker.get(id: subcategory.wallet?.id) ?? DBWalletModel(name: subcategory.wallet?.name ?? "Unknown")
        walletWorker.save(wallet: dbWallet)
        
        execute { _ in
            dbWallet.subcategories.append(dbEntry)
        }
        
        if let category = subcategory.category {
            let dbCategory = categoryWorker.get(id: category.id) ?? DBCategoryModel(name: category.name)
            categoryWorker.save(object: dbCategory)
            
            execute { _ in
                dbCategory.subcategories.append(dbEntry)
            }
        }
        
        return SubcategoryModel(dbEntry)
    }
}

extension DBSubcategoryWorker: SubcategoryRepository {
    func getSubcategories(forCategoryId categoryId: String) -> [SubcategoryModel] {
        let filter = NSPredicate(format: "ANY category.id == %@", categoryId)
        let subcategories = list(filter: filter)
        
        return subcategories.map(SubcategoryModel.init)
    }
}
