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
        return categories as! Set<Category>
    }
    
    var subcategoriesSet: Set<Subcategory> {
        return subcategories as! Set<Subcategory>
    }
    
    var entriesSet: Set<WalletEntry> {
        return entries as! Set<WalletEntry>
    }
    
    override func set<TModel>(withModel model: TModel) where TModel : DatabaseEntry {
        let wallet = model as! WalletModel
        
        name = wallet.name
    }
}

