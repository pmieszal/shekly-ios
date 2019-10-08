//
//  SheklyDataController.swift
//  Database
//
//  Created by Patryk Mieszała on 08/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation
import CoreData
import SwiftDate

public class SheklyDataController {
    
    let store: SheklyDatabaseStore
    
    let walletGroup: EntityGroup<WalletModel>
    let categoryGroup: EntityGroup<CategoryModel>
    let subcategoryGroup: EntityGroup<SubcategoryModel>
    let entryGroup: EntityGroup<WalletEntryModel>
    
    init(store: SheklyDatabaseStore) {
        self.store = store
        
        self.walletGroup = EntityGroup(store: store)
        self.categoryGroup = EntityGroup(store: store)
        self.subcategoryGroup = EntityGroup(store: store)
        self.entryGroup = EntityGroup(store: store)
    }
    
    //MARK: - Public functions
    public func getWallets() -> [WalletModel] {
        return self.walletGroup.list()
    }
    
    public func getCategories(forWallet wallet: WalletModel) -> [CategoryModel] {
        guard let walletId = wallet.id else { return [] }
        
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", "wallet.id", walletId)
        
        let categories: [CategoryModel] = self.categoryGroup.execute(request: request)
        
        return categories
    }
    
    public func getSubcategories(forCategory category: CategoryModel) -> [SubcategoryModel] {
        guard let categoryId = category.id else { return [] }
        
        let request: NSFetchRequest<Subcategory> = Subcategory.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", "category.id", categoryId)
        
        let subcategories = self.subcategoryGroup.execute(request: request)
        
        return subcategories
    }
    
    public func getWalletEntries(forWallet wallet: WalletModel) -> [WalletEntryModel] {
        guard let walletId = wallet.id else { return [] }
        
        let request: NSFetchRequest<WalletEntry> = WalletEntry.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", [#keyPath(WalletEntry.wallet.id), walletId])
        
        let entries: [WalletEntryModel] = self.entryGroup.execute(request: request)
        
        return entries
    }
    
    public func getWalletEntries(forWallet wallet: WalletModel, date: Date) -> [WalletEntryModel] {
        guard let walletId = wallet.id else { return [] }
        
        let from: Date = date.dateAtStartOf(.month)
        let to: Date = date.dateAtEndOf(.month)
        
        let request: NSFetchRequest<WalletEntry> = WalletEntry.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@ AND %K BETWEEN {%@, %@}", argumentArray: [#keyPath(WalletEntry.wallet.id), walletId, #keyPath(WalletEntry.date), from, to])
        
        let entries: [WalletEntryModel] = self.entryGroup.execute(request: request)
        
        return entries
    }
    
    public func getWalletEntries(forCategory category: CategoryModel) -> [WalletEntryModel] {
        guard let categoryId = category.id else { return [] }
        
        let request: NSFetchRequest<WalletEntry> = WalletEntry.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", "category.id", categoryId)
        
        let entries: [WalletEntryModel] = self.entryGroup.execute(request: request)
        
        return entries
    }
    
    public func save(wallet: WalletModel) -> WalletModel {
        return self.walletGroup.save(model: wallet)
    }
    
    public func save(entry: WalletEntryModel) {
        let wallet = self.save(wallet: entry.wallet)
        
        let categoryRecreated = CategoryModel(name: entry.category.name, walletId: wallet.id, properties: entry.category.properties)
        let category = self.save(category: categoryRecreated)
        
        let subcategoryRecreated = SubcategoryModel(name: entry.subcategory.name, category: category, properties: entry.subcategory.properties)
        let subcategory = self.save(subcategory: subcategoryRecreated)
        
        let entryRecreated = WalletEntryModel(entry: entry, wallet: wallet, category: category, subcategory: subcategory)
        
        self.entryGroup.save(model: entryRecreated)
    }
    
    public func delete(entry: WalletEntryModel) -> Bool {
        let success = self.entryGroup.delete(model: entry)
        
        return success
    }
    
    //MARK: - Internal functions
    func save(category: CategoryModel) -> CategoryModel {
        return self.categoryGroup.save(model: category)
    }
    
    func save(subcategory: SubcategoryModel) -> SubcategoryModel {
        return self.subcategoryGroup.save(model: subcategory)
    }
}
