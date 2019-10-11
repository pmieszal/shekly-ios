//
//  SheklyJSONDataController.swift
//  Database
//
//  Created by Patryk Mieszała on 02/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

public class SheklyJSONDataController: SheklyDataController {
    
    func save(wallet: WalletJSONModel, completionHandler: () -> ()) {
        let entries = wallet.expenses
        
        let walletModelToSave = WalletModel(name: wallet.name, properties: nil)
        let walletModel = save(wallet: walletModelToSave)
        
        for entry in entries {
            
            let categoryName: String = entry.category.lowercased()
            let subcategoryName: String = entry.subcategory.lowercased()
            let amount: Double = entry.amount
            let date: Date = entry.date
            
            let categories: [CategoryModel] = getCategories(forWallet: walletModel)
            
            let categoryOptional: CategoryModel? = categories.filter { $0.name == categoryName }.first
            let category: CategoryModel
            
            if let categoryFromDatabase = categoryOptional {
                category = categoryFromDatabase
            } else {
                category = CategoryModel(name: categoryName, walletId: walletModel.id, properties: nil)
            }
            
            let subcategories: [SubcategoryModel] = getSubcategories(forCategory: category)
            
            let subcategoryOptional: SubcategoryModel? = subcategories.filter { $0.name == subcategoryName }.first
            let subcategory: SubcategoryModel
            
            if let subcategoryFromDatabase = subcategoryOptional {
                subcategory = subcategoryFromDatabase
            } else {
                subcategory = SubcategoryModel(name: subcategoryName, category: category, properties: nil)
            }
            
            let entry: WalletEntryModel = WalletEntryModel(amount: amount,
                                                           date: date,
                                                           text: nil,
                                                           type: .outcome,
                                                           wallet: walletModel,
                                                           category: category,
                                                           subcategory: subcategory,
                                                           properties: nil)
            
            self.save(entry: entry)
        }
        
        completionHandler()
    }
}
