//
//  SheklyCategoryModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 14/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import RxDataSources
import SwiftDate
import RxMVVMC

import Database

public class SheklyCategoryModel: IdentifiableType, Equatable {
    
    public typealias Identity = String
    
    public var identity: String {
        return category.id !! "Id can't be nil"
    }
    
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
}

public func ==(lhs: SheklyCategoryModel, rhs: SheklyCategoryModel) -> Bool {
    return lhs.identity == rhs.identity
}
