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
        //swiftlint:disable:next force_cast
        return entries as! Set<WalletEntry>
    }
    
    var subcategoriesSet: Set<Subcategory> {
        //swiftlint:disable:next force_cast
        return subcategories as! Set<Subcategory>
    }
    
    override func set<TModel>(withModel model: TModel) where TModel: DatabaseEntry {
        guard let category = model as? CategoryModel else {
            fatalError("This can't happen")
        }
        name = category.name
    }
}
