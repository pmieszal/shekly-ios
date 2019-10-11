//
//  WalletEntry+CoreDataClass.swift
//  
//
//  Created by Patryk Mieszała on 08/02/2019.
//
//

import Foundation
import CoreData

@objc(WalletEntry)
public class WalletEntry: DatabaseEntity {
    
    override func set<TModel>(withModel model: TModel) where TModel: DatabaseEntry {
        guard let entry = model as? WalletEntryModel else {
            fatalError("This can't happen")
        }
        
        amount = entry.amount
        date = entry.date
        text = entry.text
        type = entry.type.rawValue
    }
}
