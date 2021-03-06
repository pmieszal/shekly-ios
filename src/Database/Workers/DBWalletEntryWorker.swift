import Domain
import RealmSwift

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
    func getWalletEntries(forWalletId walletId: String) -> [WalletEntryModel] {
        let filter = NSPredicate(format: "%K == %@", [#keyPath(DBWalletEntryModel.id), walletId])
        let entries = list(filter: filter)
        
        return entries.map(WalletEntryModel.init)
    }
    
    func getWalletEntries(forWalletId walletId: String, monthDate: Date) -> [WalletEntryModel] {
        let from: Date = monthDate.dateAtStartOf(.month)
        let to: Date = monthDate.dateAtEndOf(.month)
        
        let walletFilter = NSPredicate(
            format: "ANY wallet.id == %@",
            argumentArray: [
                walletId,
            ])
        
        let dateFilter = NSPredicate(
            format: "date BETWEEN {%@, %@}",
            argumentArray: [
                from,
                to,
            ])
        
        let entries = realm
            .objects(DBWalletEntryModel.self)
            .filter(walletFilter)
            .filter(dateFilter)
        
        return entries.map(WalletEntryModel.init)
    }
    
    func save(entry: WalletEntryModel) {
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
    }
    
    func delete(entry: WalletEntryModel) -> Bool {
        let model = DBWalletEntryModel(entry)
        remove(object: model)
        
        return true
    }
}
