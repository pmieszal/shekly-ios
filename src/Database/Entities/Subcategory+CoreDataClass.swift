//
//  Subcategory+CoreDataClass.swift
//  
//
//  Created by Patryk Mieszała on 08/02/2019.
//
//

import Foundation
import CoreData

@objc(Subcategory)
public class Subcategory: DatabaseEntity {
    
    var entriesSet: Set<WalletEntry> {
        return self.entries as! Set<WalletEntry>
    }

    override func set<TModel>(withModel model: TModel) where TModel : DatabaseEntry {
        let subcategory = model as! SubcategoryModel
        
        self.name = subcategory.name
    }
}
