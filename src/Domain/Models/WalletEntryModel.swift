//
//  WalletEntryModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 13/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import SwiftDate

public struct WalletEntryModel: Hashable {
    public let
    id: String?,
    type: WalletEntryType,
    text: String,
    amount: Double,
    wallet: SimplyWalletModel?,
    category: SimplyCategoryModel?,
    subcategory: SimplySubcategoryModel?,
    date: Date,
    dateString: String
    
    public var categoryAndComment: String? {
        guard let category = category?.name else {
            return text
        }
        
        return category + " - " + text
    }
    
    public init(id: String?,
                type: WalletEntryType,
                text: String,
                date: Date,
                amount: Double,
                wallet: SimplyWalletModel?,
                category: SimplyCategoryModel?,
                subcategory: SimplySubcategoryModel?) {
        self.id = id
        self.type = type
        self.text = text
        self.amount = amount
        self.date = date
        self.wallet = wallet
        self.category = category
        self.subcategory = subcategory
        
//        amountText = type
//            .textPrefix
//            .appending(" ")
//            .appending(formatter.getCurrencyString(fromNumber: amount) ?? "")
        
        dateString = date.toString(DateToStringStyles.date(DateFormatter.Style.long))
    }
    
    public init() {
        id = nil
        type = .income
        text = ""
        amount = 0
        date = Date()
        wallet = nil
        category = nil
        subcategory = nil
        dateString = ""
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id ?? "empty")
    }

    public static func == (lhs: WalletEntryModel, rhs: WalletEntryModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

public extension Array where Element == WalletEntryModel {
    func sorted() -> [Element] {
        return sorted { (left, right) -> Bool in
            return left.date > right.date
        }
    }
}
