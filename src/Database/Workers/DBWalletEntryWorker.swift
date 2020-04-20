//
//  DBWalletEntryWorker.swift
//  Database
//
//  Created by Patryk Mieszała on 19/04/2020.
//

import RealmSwift
import Domain

class DBWalletEntryWorker: DBGroup<DBWalletEntryModel> {
    let walletWorker: DBWalletWorker
    let categoryWorker: DBCategoryWorker
    let subcategoryWorker: DBSubcategoryWorker
    
    init(realm: Realm,
         walletWorker: DBWalletWorker,
         categoryWorker: DBCategoryWorker,
         subcategoryWorker: DBSubcategoryWorker) {
        self.walletWorker = walletWorker
        self.categoryWorker = categoryWorker
        self.subcategoryWorker = subcategoryWorker
        super.init(realm: realm)
    }
}

extension DBWalletEntryWorker: WalletEntriesRepository {
    func getWalletEntries(forWallet wallet: WalletModel) -> [WalletEntryModel] {
        guard let walletId = wallet.id else {
            return []
        }
        
        let filter = NSPredicate(format: "%K == %@", [#keyPath(DBWalletEntryModel.id), walletId])
        let entries = list(filter: filter)
        
        return entries.map(WalletEntryModel.init)
    }
    
    func getWalletEntries(forWallet wallet: WalletModel, date: Date) -> [WalletEntryModel] {
        guard let walletId = wallet.id else {
            return []
        }
        
        let from: Date = date.dateAtStartOf(.month)
        let to: Date = date.dateAtEndOf(.month)

        let walletFilter = NSPredicate(
            format: "ANY wallet.id == %@",
            argumentArray: [
                walletId
        ])

        let dateFilter = NSPredicate(
            format: "date BETWEEN {%@, %@}",
            argumentArray: [
                from,
                to
        ])
        
        let entries = realm
            .objects(DBWalletEntryModel.self)
            .filter(walletFilter)
            .filter(dateFilter)
            
        return entries.map(WalletEntryModel.init)
    }
    
    func save(entry: WalletEntryModel) -> WalletEntryModel {
        let dbEntry = DBWalletEntryModel(entry)
        
        let dbWallet = walletWorker.get(id: entry.wallet?.id) ?? DBWalletModel(name: entry.wallet?.name ?? "Unknown")
        walletWorker.save(wallet: dbWallet)
        
        execute { _ in
            dbWallet.entries.append(dbEntry)
        }
        
        if let category = entry.category {
            let dbCategory = categoryWorker.get(id: category.id) ?? DBCategoryModel(name: category.name)
            categoryWorker.save(object: dbCategory)
            
            execute { _ in
                dbCategory.entries.append(dbEntry)
            }
        }
        
        if let subcategory = entry.subcategory {
            let dbSubcategory = subcategoryWorker.get(id: subcategory.id) ?? DBSubcategoryModel(name: subcategory.name)
            subcategoryWorker.save(object: dbSubcategory)
            
            execute { _ in
                dbSubcategory.entries.append(dbEntry)
            }
        }
        
        return WalletEntryModel(dbEntry)
    }
    
    func delete(entry: WalletEntryModel) -> Bool {
        let model = DBWalletEntryModel(entry)
        remove(object: model)
        
        return true
    }
}
