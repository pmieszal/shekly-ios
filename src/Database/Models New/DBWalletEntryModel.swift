//
//  DBWalletEntryModel.swift
//  Database
//
//  Created by Patryk Mieszała on 19/04/2020.
//

import RealmSwift
import Domain

class DBWalletEntryModel: DBModel {
    @objc dynamic var text = ""
    @objc dynamic var date = Date()
    @objc dynamic var amount = Double(0)
    @objc dynamic var type = Int(0)
    let wallet = LinkingObjects(fromType: DBWalletModel.self, property: "entries")
//    let category = LinkingObjects(fromType: DBCategoryModel.self, property: "entries")
//    let subcategory = LinkingObjects(fromType: DBSubcategoryModel.self, property: "entries")
    
    convenience init(_ entry: WalletEntryModel) {
        self.init()
        
        id = entry.id
        text = entry.text
        date = entry.date
        amount = entry.amount
        type = entry.type.rawValue
        
        //TODO: figure out linking
    }
    
    convenience init?(_ entry: WalletEntryModel?) {
        guard let entry = entry else {
            return nil
        }
        
        self.init(entry)
    }
}

extension WalletEntryModel {
    init(_ entry: DBWalletEntryModel) {
        self.init(
            id: entry.id,
            type: WalletEntryType(entry.type),
            text: entry.text,
            date: entry.date,
            amount: entry.amount,
            wallet: WalletModel(entry.wallet.first),
            category: nil, // CategoryModel(entry.category.first),
            subcategory: nil) // SubcategoryModel(entry.subcategory.first))
    }
    
    init?(_ entry: DBWalletEntryModel?) {
        guard let entry = entry else {
            return nil
        }
        
        self.init(entry)
    }
}

extension WalletEntryType {
    init(_ type: Int) {
        guard let type = WalletEntryType(rawValue: type) else {
            fatalError("Fix your code")
        }
        
        self = type
    }
}
