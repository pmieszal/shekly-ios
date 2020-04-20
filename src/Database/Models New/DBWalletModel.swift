//
//  DBWalletModel.swift
//  Database
//
//  Created by Patryk Mieszała on 19/04/2020.
//

import RealmSwift
import Domain

class DBWalletModel: DBModel {
    @objc dynamic var name = ""
    let categories = List<DBCategoryModel>()
    let subcategories = List<DBSubcategoryModel>()
    let entries = List<DBWalletEntryModel>()
    
    convenience init(_ wallet: WalletModel) {
        self.init()
        id = wallet.id ?? NSUUID().uuidString
        name = wallet.name ?? ""
    }
    
    convenience init?(_ wallet: WalletModel?) {
        guard let wallet = wallet else {
            return nil
        }
        
        self.init(wallet)
    }
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}

extension WalletModel {
    init(_ wallet: DBWalletModel) {
        self.init(
            id: wallet.id,
            name: wallet.name,
            entries: wallet.entries.map(WalletEntryModel.init))
    }
    
    init?(_ wallet: DBWalletModel?) {
        guard let wallet = wallet else {
            return nil
        }
        
        self.init(wallet)
    }
}
