//
//  CategoryViewModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 26/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import RxSwift
import RxCocoa

import User
import Database
import Shared

public class CategoryViewModel: SheklyViewModel {
    
    //MARK: - Public properties
    public let feed: Driver<[CategoryCellViewModel]>
    
    public let categoryName: String
    
    //MARK: - Internal properties
    let feedRelay: BehaviorRelay<[CategoryCellViewModel]> = .init(value: [])
    
    let sheklyCategoryModel: SheklyCategoryModel
    let dataController: SheklyDataController
    let currencyFormatter: SheklyCurrencyFormatter
    
    //MARK: - Constructor
    init(
        category: SheklyCategoryModel,
        dataController: SheklyDataController,
        currencyFormatter: SheklyCurrencyFormatter
        ) {
        self.sheklyCategoryModel = category
        self.dataController = dataController
        self.currencyFormatter = currencyFormatter
        
        self.feed = self.feedRelay.asDriver()
        
        self.categoryName = category.categoryText
        
        super.init()
    }
    
    //MARK: - Public methods
    public override func viewWillAppear() {
        super.viewWillAppear()
        
        self.reloadFeed()
    }
}

//MARK: - Internal methods
extension CategoryViewModel {
    
    func reloadFeed() {
        let headerVM: CategoryHeaderCellViewModel = CategoryHeaderCellViewModel(category: self.sheklyCategoryModel.category, formatter: self.currencyFormatter)
        
        let subcategories: [SubcategoryModel] = self.dataController.getSubcategories(forCategory: self.sheklyCategoryModel.category)
        let subcategoriesVM: CategorySubcategoriesCellViewModel = CategorySubcategoriesCellViewModel(subcategories: subcategories, formatter: self.currencyFormatter)
        
        let entries: [WalletEntryModel] = self.dataController.getWalletEntries(forCategory: self.sheklyCategoryModel.category)
        let entriesVMs: [CategoryCellViewModel] = entries
            .map { [unowned self] entry in
                return SheklyWalletEntryModel(entry: entry, formatter: self.currencyFormatter)
        }
        
        let feed: [CategoryCellViewModel] = [headerVM, subcategoriesVM] + entriesVMs
        self.feedRelay.accept(feed)
    }
}
