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
        //swiftlint:disable:next force_cast
        return entries as! Set<WalletEntry>
    }

    override func set<TModel>(withModel model: TModel) where TModel: DatabaseEntry {
        guard let subcategory = model as? SubcategoryModel else {
            fatalError("This can't happen")
        }
        name = subcategory.name
    }
}
