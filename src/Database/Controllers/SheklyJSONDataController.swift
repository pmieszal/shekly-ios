//
//  SheklyJSONDataController.swift
//  Database
//
//  Created by Patryk Mieszała on 02/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Domain

public class SheklyJSONDataController {
    let walletWorker: DBWalletWorker
    let categoryWorker: DBCategoryWorker
    let subcategoryWorker: DBSubcategoryWorker
    let entryWorker: DBWalletEntryWorker
    
    init(walletWorker: DBWalletWorker,
         categoryWorker: DBCategoryWorker,
         subcategoryWorker: DBSubcategoryWorker,
         entryWorker: DBWalletEntryWorker) {
        self.walletWorker = walletWorker
        self.categoryWorker = categoryWorker
        self.subcategoryWorker = subcategoryWorker
        self.entryWorker = entryWorker
    }
    
    func save(wallet: WalletJSONModel, completionHandler: () -> ()) {
        let entries = wallet.expenses
        
        let walletModelToSave = WalletModel(id: nil, name: wallet.name, entries: [])
        let walletModel = walletWorker.save(wallet: walletModelToSave)
        
        for entry in entries {
            let categoryName: String = entry.category.lowercased()
            let subcategoryName: String = entry.subcategory.lowercased()
            let amount: Double = entry.amount
            let date: Date = entry.date
            
            let categories = categoryWorker.getCategories(forWallet: walletModel)
            
            let categoryOptional = categories.filter { $0.name == categoryName }.first
            let category: CategoryModel
            
            if let categoryFromDatabase = categoryOptional {
                category = categoryFromDatabase
            } else {
                category = CategoryModel(
                    id: nil,
                    name: categoryName,
                    wallet: walletModel,
                    subcategories: [])
            }
            
            let subcategories = subcategoryWorker.getSubcategories(forCategory: category)
            
            let subcategoryOptional = subcategories.filter { $0.name == subcategoryName }.first
            let subcategory: SubcategoryModel
            
            if let subcategoryFromDatabase = subcategoryOptional {
                subcategory = subcategoryFromDatabase
            } else {
                subcategory = SubcategoryModel(
                    id: nil,
                    name: subcategoryName,
                    wallet: walletModel,
                    category: category)
            }
            
            let entry = WalletEntryModel(
                id: nil,
                type: .outcome,
                text: "",
                date: date,
                amount: amount,
                wallet: walletModel,
                category: category,
                subcategory: subcategory)
            
            _ = entryWorker.save(entry: entry)
        }
        
        completionHandler()
    }
}
