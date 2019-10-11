//
//  CategoryViewModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 26/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import User
import Database
import Shared

public class CategoryViewModel: SheklyViewModel {
    // MARK: - Public properties
    public private(set) var feed: [CategoryCellViewModel] = []
    public let categoryName: String
    
    // MARK: - Internal properties
    let sheklyCategoryModel: SheklyCategoryModel
    let dataController: SheklyDataController
    let currencyFormatter: SheklyCurrencyFormatter
    
    // MARK: - Constructor
    init(
        category: SheklyCategoryModel,
        dataController: SheklyDataController,
        currencyFormatter: SheklyCurrencyFormatter
        ) {
        self.sheklyCategoryModel = category
        self.dataController = dataController
        self.currencyFormatter = currencyFormatter
        
        self.categoryName = category.categoryText
    }
    
    // MARK: - Public methods
    public override func viewWillAppear() {
        super.viewWillAppear()
        
        reloadFeed()
    }
}

// MARK: - Internal methods
extension CategoryViewModel {
    func reloadFeed() {
        let headerVM: CategoryHeaderCellViewModel = CategoryHeaderCellViewModel(category: sheklyCategoryModel.category, formatter: currencyFormatter)
        
        let subcategories: [SubcategoryModel] = dataController.getSubcategories(forCategory: sheklyCategoryModel.category)
        let subcategoriesVM = CategorySubcategoriesCellViewModel(subcategories: subcategories,
                                                                 formatter: currencyFormatter)
        
        let entries: [WalletEntryModel] = dataController.getWalletEntries(forCategory: sheklyCategoryModel.category)
        let entriesVMs: [CategoryCellViewModel] = entries
            .map { entry in
                return SheklyWalletEntryModel(entry: entry, formatter: currencyFormatter)
        }
        
        let feed: [CategoryCellViewModel] = [headerVM, subcategoriesVM] + entriesVMs
        self.feed = feed
    }
}
