//
//  DBCategoryWorker.swift
//  Database
//
//  Created by Patryk Mieszała on 19/04/2020.
//

import RealmSwift
import Domain

class DBCategoryWorker: DBGroup<DBCategoryModel> {
    let walletWorker: DBWalletWorker
    
    init(realm: Realm, walletWorker: DBWalletWorker) {
        self.walletWorker = walletWorker
        super.init(realm: realm)
    }
    
    func getCategories(forWallet wallet: WalletModel) -> [CategoryModel] {
        guard let walletId = wallet.id else {
            return []
        }
        
        return getCategories(forWalletId: walletId)
    }
    
    func save(category: CategoryModel) -> CategoryModel {
        let dbEntry = DBCategoryModel(category)
        
        let dbWallet = walletWorker.get(id: category.wallet?.id) ?? DBWalletModel(name: category.wallet?.name ?? "Unknown")
        walletWorker.save(wallet: dbWallet)
        
        execute { _ in
            dbWallet.categories.append(dbEntry)
        }
        
        return CategoryModel(dbEntry)
    }
}

extension DBCategoryWorker: CategoryRepository {
    func getCategories(forWalletId walletId: String) -> [CategoryModel] {
        let filter = NSPredicate(format: "ANY wallet.id = %@", walletId)
        let categories = list(filter: filter)
        
        return categories.map(CategoryModel.init)
    }
}
