//
//  SheklyWalletEntryModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 13/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import SwiftDate
import RxMVVMC

import Database

public class SheklyWalletEntryModel: SheklyEntryModel {
    
    public override var hashValue: Int {
        return entry.id?.hashValue !! "Id can't be nil"
    }
    
    let entry: WalletEntryModel
    
    init(entry: WalletEntryModel, formatter: SheklyCurrencyFormatter) {
        self.entry = entry
        
        let categoryAndComment: String?
        if let category = entry.category.name, let text = entry.text {
            categoryAndComment = category + " - " + text
        }
        else {
            categoryAndComment = entry.category.name
        }
        
        let subcategory: String? = entry.subcategory.name
        
        let amount: String? = "\(entry.type.textPrefix) " + (formatter.getCurrencyString(fromNumber: entry.amount) ?? "")
        
        let date: Date? = entry.date
        let dateString: String? =  date?.toString(DateToStringStyles.date(DateFormatter.Style.long))
        
        super.init(categoryAndComment: categoryAndComment, subcategory: subcategory, amount: amount, amountColor: entry.type.textColor, dateString: dateString)
    }
}
