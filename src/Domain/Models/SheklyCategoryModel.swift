//
//  SheklyCategoryModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 14/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import SwiftDate

public class SheklyCategoryModel: Hashable, Equatable {
    public let
    categoryId: String,
    categoryText: String,
    subcategoriesText: String,
    entriesText: String,
    amount: Double,
    amountText: String
    
    init(categoryId: String,
         categoryText: String,
         subcategoriesText: String,
         entriesText: String,
         amount: Double,
         amountText: String) {
        self.categoryId = categoryId
        self.categoryText = categoryText
        self.subcategoriesText = subcategoriesText
        self.entriesText = entriesText
        self.amount = amount
        self.amountText = amountText
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(categoryId)
    }
}

public func == (lhs: SheklyCategoryModel, rhs: SheklyCategoryModel) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
