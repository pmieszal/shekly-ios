//
//  CategoryViewModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 26/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import User
import Domain
import CleanArchitectureHelpers
import Common

public class CategoryViewModel: ViewModel {
    // MARK: - Public properties
    public private(set) var feed: [CategoryCellViewModel] = []
    public let categoryName: String
    
    // MARK: - Internal properties
    let sheklyCategoryModel: SheklyCategoryModel
    //let dataController: SheklyDataController
    let currencyFormatter: SheklyCurrencyFormatter
    
    // MARK: - Constructor
    init(category: SheklyCategoryModel,
         //dataController: SheklyDataController,
         currencyFormatter: SheklyCurrencyFormatter) {
        self.sheklyCategoryModel = category
        //self.dataController = dataController
        self.currencyFormatter = currencyFormatter
        
        self.categoryName = category.categoryText
    }
    
    // MARK: - Public methods
    public func viewWillAppear() {
        reloadFeed()
    }
}

// MARK: - Internal methods
extension CategoryViewModel {
    func reloadFeed() {
        let headerVM: CategoryHeaderCellViewModel = CategoryHeaderCellViewModel(category: sheklyCategoryModel, formatter: currencyFormatter)
        
        let subcategories: [SheklySubcategoryModel] = [] //dataController.getSubcategories(forCategory: sheklyCategoryModel.category)
        let subcategoriesVM = CategorySubcategoriesCellViewModel(subcategories: subcategories,
                                                                 formatter: currencyFormatter)
        
        let entries: [SheklyWalletEntryModel] = [] // dataController.getWalletEntries(forCategory: sheklyCategoryModel)
        let entriesVMs: [CategoryCellViewModel] = entries
        
        let feed: [CategoryCellViewModel] = [headerVM, subcategoriesVM] + entriesVMs
        self.feed = feed
    }
}
