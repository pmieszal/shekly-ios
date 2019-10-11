//
//  Wallet+CoreDataClass.swift
//  Database
//
//  Created by Patryk Mieszała on 23/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation
import CoreData

@objc(Wallet)
public class Wallet: DatabaseEntity {
    
    var categoriesSet: Set<Category> {
        //swiftlint:disable:next force_cast
        return categories as! Set<Category>
    }
    
    var subcategoriesSet: Set<Subcategory> {
        //swiftlint:disable:next force_cast
        return subcategories as! Set<Subcategory>
    }
    
    var entriesSet: Set<WalletEntry> {
        //swiftlint:disable:next force_cast
        return entries as! Set<WalletEntry>
    }
    
    override func set<TModel>(withModel model: TModel) where TModel: DatabaseEntry {
        guard let wallet = model as? WalletModel else {
            fatalError("This can't happen")
        }
        
        name = wallet.name
    }
}
