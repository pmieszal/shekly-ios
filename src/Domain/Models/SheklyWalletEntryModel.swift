//
//  SheklyWalletEntryModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 13/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import SwiftDate

public class SheklyWalletEntryModel: Hashable {
    public let entryType: WalletEntryType?
    public let categoryAndComment: String?
    public let subcategory: String?
    public let amount: String?
    public let dateString: String?
    
    let id: String?
    let date: Date?
    
    init(entryId: String?,
         entryDate: Date?,
         entryAmount: Double?,
         entryText: String?,
         entryType: WalletEntryType?,
         categoryName: String?,
         subcategoryName: String?,
         formatter: SheklyCurrencyFormatter) {
        let categoryAndComment: String?
        
        if let category = categoryName, let text = entryText {
            categoryAndComment = category + " - " + text
        } else {
            categoryAndComment = categoryName
        }
        
        
        let amount = entryType?
            .textPrefix
            .appending(" ")
            .appending(formatter.getCurrencyString(fromNumber: entryAmount) ?? "")
        
        let dateString: String? =  entryDate?.toString(DateToStringStyles.date(DateFormatter.Style.long))
        
        self.id = entryId
        self.date = entryDate
        self.categoryAndComment = categoryAndComment
        self.subcategory = subcategoryName
        self.amount = amount
        self.entryType = entryType
        self.dateString = dateString
    }
    
    init() {
        categoryAndComment = nil
        subcategory = nil
        amount = nil
        entryType = nil
        dateString = nil
        id = nil
        date = nil
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

extension Array where Element == SheklyWalletEntryModel {
    func sorted() -> [Element] {
        return sorted { (left, right) -> Bool in
            guard let leftDate = left.date,
                let rightDate = right.date else {
                    return false
            }
            
            return leftDate > rightDate
        }
    }
}
