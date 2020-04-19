//
//  DBCategoryWorker.swift
//  Database
//
//  Created by Patryk Mieszała on 19/04/2020.
//

import Domain

class DBCategoryWorker: DBGroup<DBCategoryModel> {
    func getCategories(forWallet wallet: WalletModel) -> [CategoryModel] {
        guard let walletId = wallet.id else {
            return []
        }
        
        let filter = NSPredicate(format: "ANY wallet.id = %@", walletId)
        let categories = list(filter: filter)
        
        return categories.map(CategoryModel.init)
    }
}
