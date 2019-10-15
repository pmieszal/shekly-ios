//
//  SheklyWalletEntryModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 13/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import SwiftDate

import Database

public class SheklyWalletEntryModel: Hashable {
    public let categoryAndComment: String?
    public let subcategory: String?
    public let amount: String?
    public let amountColor: UIColor?
    public let dateString: String?
    
    let id: String?
    let entry: WalletEntryModel?
    
    init(entry: WalletEntryModel?, formatter: SheklyCurrencyFormatter) {
        self.entry = entry
        
        let categoryAndComment: String?
        if let category = entry?.category.name, let text = entry?.text {
            categoryAndComment = category + " - " + text
        } else {
            categoryAndComment = entry?.category.name
        }
        
        let subcategory: String? = entry?.subcategory.name
        
        let amount = entry?.type.textPrefix
            .appending(" ")
            .appending(formatter.getCurrencyString(fromNumber: entry?.amount) ?? "")
        
        let date: Date? = entry?.date
        let dateString: String? =  date?.toString(DateToStringStyles.date(DateFormatter.Style.long))
        
        self.id = entry?.id
        self.categoryAndComment = categoryAndComment
        self.subcategory = subcategory
        self.amount = amount
        self.amountColor = entry?.type.textColor
        self.dateString = dateString
    }
    
    init() {
        categoryAndComment = nil
        subcategory = nil
        amount = nil
        amountColor = nil
        dateString = nil
        id = nil
        entry = nil
    }
    
    public func hash(into hasher: inout Hasher) {
        if let id = id {
            hasher.combine(id)
        } else {
            hasher.combine(NSUUID())
        }
    }
}

public func ==<T: SheklyWalletEntryModel>(lhs: T, rhs: T) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
