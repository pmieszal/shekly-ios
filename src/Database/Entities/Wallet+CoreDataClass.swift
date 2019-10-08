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
        return self.categories as! Set<Category>
    }
    
    var subcategoriesSet: Set<Subcategory> {
        return self.subcategories as! Set<Subcategory>
    }
    
    var entriesSet: Set<WalletEntry> {
        return self.entries as! Set<WalletEntry>
    }
    
    override func set<TModel>(withModel model: TModel) where TModel : DatabaseEntry {
        let wallet = model as! WalletModel
        
        self.name = wallet.name
    }
}

