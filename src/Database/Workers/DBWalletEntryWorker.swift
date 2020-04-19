//
//  DBWalletEntryWorker.swift
//  Database
//
//  Created by Patryk Mieszała on 19/04/2020.
//

import RealmSwift
import Domain

class DBWalletEntryWorker: DBGroup<DBWalletEntryModel> {
    var walletWorker: DBWalletWorker!
    
    convenience init(realm: Realm, walletWorker: DBWalletWorker) {
        self.init(realm: realm)
        self.walletWorker = walletWorker
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

        let filter = NSPredicate(format: "%K == %@ AND %K BETWEEN {%@, %@}",
                                 argumentArray: [
                                    #keyPath(DBWalletEntryModel.id),
                                    walletId,
                                    #keyPath(DBWalletEntryModel.date),
                                    from,
                                    to
        ])
        
        let entries = list(filter: filter)
        
        return entries.map(WalletEntryModel.init)
    }
    
    func save(entry: WalletEntryModel) -> WalletEntryModel? {
        let dbEntry = DBWalletEntryModel(entry)
        
        if let walletId = entry.wallet?.id,
            let dbWallet = walletWorker.getWallet(id: walletId) {
            
            execute { (realm) in
                dbWallet.entries.append(dbEntry)
            }
        } else {
            let dbWallet = DBWalletModel()
            dbWallet.name = entry.wallet?.name ?? ""
            walletWorker.save(wallet: dbWallet)
            
            execute { (realm) in
                dbWallet.entries.append(dbEntry)
            }
        }
        
        let saved = get(id: entry.id)
        
        return WalletEntryModel(saved)
    }
    
    func delete(entry: WalletEntryModel) -> Bool {
        let model = DBWalletEntryModel(entry)
        remove(object: model)
        
        return true
    }
}
