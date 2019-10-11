//
//  Category+CoreDataClass.swift
//  
//
//  Created by Patryk Mieszała on 08/02/2019.
//
//

import Foundation
import CoreData

@objc(Category)
public class Category: DatabaseEntity {
    
    var entriesSet: Set<WalletEntry> {
        return entries as! Set<WalletEntry>
    }
    
    var subcategoriesSet: Set<Subcategory> {
        return subcategories as! Set<Subcategory>
    }
    
    override func set<TModel>(withModel model: TModel) where TModel : DatabaseEntry {
        let category = model as! CategoryModel
        name = category.name
    }
}
