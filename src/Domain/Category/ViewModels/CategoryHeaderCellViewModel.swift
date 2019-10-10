//
//  CategoryHeaderCellViewModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 26/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import User
import Database
import Shared

public class CategoryHeaderCellViewModel: CategoryCellViewModel {
    
    public let name: String?
    public let amountText: String?
    
    init(category: CategoryModel, formatter: SheklyCurrencyFormatter) {
        self.name = category.name
        self.amountText = formatter.getCurrencyString(fromNumber: category.amount)
    }
}
