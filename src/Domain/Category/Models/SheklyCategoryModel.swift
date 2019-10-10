//
//  SheklyCategoryModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 14/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import SwiftDate
import Database

public class SheklyCategoryModel: Hashable, Equatable {
    
    public let categoryText: String
    public let subcategoriesText: String
    public let entriesText: String
    public let amountText: String
    
    let category: CategoryModel
    
    init(category: CategoryModel, formatter: SheklyTokenFormatter) {
        self.category = category
        
        self.categoryText = WalletTokenModel(category: category, formatter: formatter).label
        self.subcategoriesText = "Subcategories: " + String(category.subcategoryIds.count)
        self.entriesText = "Entries: " + String(category.entriesIds.count)
        self.amountText = WalletTokenModel(amount: category.amount, formatter: formatter).label
    }
    
    public func hash(into hasher: inout Hasher) {
        guard let id = category.id else {
            fatalError("Id can't be nil")
        }
        
        hasher.combine(id)
    }
}

public func ==(lhs: SheklyCategoryModel, rhs: SheklyCategoryModel) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
