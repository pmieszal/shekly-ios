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
    
    override func set<TModel>(withModel model: TModel) where TModel : DatabaseEntry {
        let entry = model as! WalletEntryModel
        
        self.amount = entry.amount
        self.date = entry.date
        self.text = entry.text
        self.type = entry.type.rawValue
    }
}
