//
//  SheklyDataController.swift
//  Database
//
//  Created by Patryk Mieszała on 08/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation
import CoreData
import Domain

public class SheklyDataController {
    
    let store: SheklyDatabaseStore
    
    let walletGroup: EntityGroup<WalletModel>
    let categoryGroup: EntityGroup<CategoryModel>
    let subcategoryGroup: EntityGroup<SubcategoryModel>
    let entryGroup: EntityGroup<WalletEntryModel>
    
    init(store: SheklyDatabaseStore) {
        self.store = store
        
        walletGroup = EntityGroup(store: store)
        categoryGroup = EntityGroup(store: store)
        subcategoryGroup = EntityGroup(store: store)
        entryGroup = EntityGroup(store: store)
    }
    
    // MARK: - Public functions
    public func getWallets() -> [WalletModel] {
        return walletGroup.list()
    }
    
    public func getCategories(forWallet wallet: WalletModel) -> [CategoryModel] {
        guard let walletId = wallet.id else {
            return []
        }
        
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", "wallet.id", walletId)
        
        let categories: [CategoryModel] = categoryGroup.execute(request: request)
        
        return categories
    }
    
    public func getSubcategories(forCategory category: CategoryModel) -> [SubcategoryModel] {
        guard let categoryId = category.id else {
            return []
        }
        
        let request: NSFetchRequest<Subcategory> = Subcategory.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", "category.id", categoryId)
        
        let subcategories = subcategoryGroup.execute(request: request)
        
        return subcategories
    }
    
    public func getWalletEntries(forWallet wallet: WalletModel) -> [WalletEntryModel] {
        guard let walletId = wallet.id else {
            return []
        }
        
        let request: NSFetchRequest<WalletEntry> = WalletEntry.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", [#keyPath(WalletEntry.wallet.id), walletId])
        
        let entries: [WalletEntryModel] = entryGroup.execute(request: request)
        
        return entries
    }
    
    public func getWalletEntries(forWallet wallet: WalletModel, date: Date) -> [WalletEntryModel] {
        guard let walletId = wallet.id else {
            return []
        }
        
        let from: Date = date.dateAtStartOf(.month)
        let to: Date = date.dateAtEndOf(.month)
        
        let request: NSFetchRequest<WalletEntry> = WalletEntry.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@ AND %K BETWEEN {%@, %@}",
                                        argumentArray: [
                                            #keyPath(WalletEntry.wallet.id),
                                            walletId, #keyPath(WalletEntry.date),
                                            from,
                                            to
        ])
        
        let entries: [WalletEntryModel] = entryGroup.execute(request: request)
        
        return entries
    }
    
    public func getWalletEntries(forCategory category: CategoryModel) -> [WalletEntryModel] {
        guard let categoryId = category.id else {
            return []
        }
        
        let request: NSFetchRequest<WalletEntry> = WalletEntry.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", "category.id", categoryId)
        
        let entries: [WalletEntryModel] = entryGroup.execute(request: request)
        
        return entries
    }
    
    public func save(wallet: WalletModel) -> WalletModel {
        return walletGroup.save(model: wallet)
    }
    
    public func save(entry: WalletEntryModel) {
        let wallet = save(wallet: entry.wallet)
        
        let categoryRecreated = CategoryModel(name: entry.category.name, walletId: wallet.id, properties: entry.category.properties)
        let category = save(category: categoryRecreated)
        
        let subcategoryRecreated = SubcategoryModel(name: entry.subcategory.name, category: category, properties: entry.subcategory.properties)
        let subcategory = save(subcategory: subcategoryRecreated)
        
        let entryRecreated = WalletEntryModel(entry: entry, wallet: wallet, category: category, subcategory: subcategory)
        
        entryGroup.save(model: entryRecreated)
    }
    
    public func delete(entry: WalletEntryModel) -> Bool {
        let success = entryGroup.delete(model: entry)
        
        return success
    }
    
    // MARK: - Internal functions
    func save(category: CategoryModel) -> CategoryModel {
        return categoryGroup.save(model: category)
    }
    
    func save(subcategory: SubcategoryModel) -> SubcategoryModel {
        return subcategoryGroup.save(model: subcategory)
    }
}

extension SheklyDataController: WalletRepository {
    public func getWallets() -> [SheklyWalletModel] {
        let wallets: [WalletModel] = getWallets()
        let models = wallets.map(SheklyWalletModel.init)
        
        return models
    }
    
    public func save(wallet: SheklyWalletModel) -> SheklyWalletModel {
        //TODO: this
        
        return wallet
    }
}

extension SheklyDataController: WalletEntriesRepository {
    //TODO: this
    public func getWalletEntries(forWallet wallet: SheklyWalletModel) -> [SheklyWalletEntryModel] {
        return []
    }
    
    public func getWalletEntries(forWallet wallet: SheklyWalletModel, date: Date) -> [SheklyWalletEntryModel] {
        return []
    }
    
    public func getWalletEntries(forCategory category: SheklyCategoryModel) -> [SheklyWalletEntryModel] {
        return []
    }
    
    public func save(entry: SheklyWalletEntryModel) -> SheklyWalletEntryModel {
        return entry
    }
    
    public func delete(entry: SheklyWalletEntryModel) -> Bool {
        return true
    }
}

extension SheklyWalletModel {
    init(wallet: WalletModel) {
        self.init(name: wallet.name, id: wallet.id)
    }
}
