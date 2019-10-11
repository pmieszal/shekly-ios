//
//  SheklyWalletEntryModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 13/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import SwiftDate

import Database

public class SheklyWalletEntryModel: SheklyEntryModel {
    let entry: WalletEntryModel
    
    init(entry: WalletEntryModel, formatter: SheklyCurrencyFormatter) {
        self.entry = entry
        
        let categoryAndComment: String?
        if let category = entry.category.name, let text = entry.text {
            categoryAndComment = category + " - " + text
        } else {
            categoryAndComment = entry.category.name
        }
        
        let subcategory: String? = entry.subcategory.name
        
        let amount: String? = "\(entry.type.textPrefix) " + (formatter.getCurrencyString(fromNumber: entry.amount) ?? "")
        
        let date: Date? = entry.date
        let dateString: String? =  date?.toString(DateToStringStyles.date(DateFormatter.Style.long))
        
        super.init(categoryAndComment: categoryAndComment,
                   subcategory: subcategory,
                   amount: amount,
                   amountColor: entry.type.textColor,
                   dateString: dateString)
    }
    
    public override func hash(into hasher: inout Hasher) {
        guard let id = entry.id else {
            assertionFailure("Id can't be nil")
            return
        }
        
        hasher.combine(id)
    }
}
