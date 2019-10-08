//
//  WalletEntryModel.swift
//  Database
//
//  Created by Patryk Mieszała on 13/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import CoreData

public class WalletEntryModel: DatabaseModel<WalletEntry> {
    
    public let amount: Double
    public let date: Date?
    public let text: String?
    public let type: WalletEntryType
    
    public let wallet: WalletModel
    public let category: CategoryModel
    public let subcategory: SubcategoryModel
    
    public init(
        amount: Double,
        date: Date?,
        text: String?,
        type: WalletEntryType,
        wallet: WalletModel,
        category: CategoryModel,
        subcategory: SubcategoryModel,
        properties: DatabaseModelProperties?
        ) {
        self.amount = amount
        self.date = date
        self.text = text
        self.type = type
        
        self.wallet = wallet
        self.category = category
        self.subcategory = subcategory
        
        super.init(properties: properties)
    }
    
    required init(entity: WalletEntry) {
        self.amount = entity.amount
        self.date = entity.date
        self.text = entity.text
        self.type = WalletEntryType(rawValue: entity.type)!
        
        self.wallet = WalletModel(entity: entity.wallet!)
        self.category = CategoryModel(entity: entity.category!)
        self.subcategory = SubcategoryModel(entity: entity.subcategory!)
        
        super.init(entity: entity)
    }
    
    init(entry: WalletEntryModel, wallet: WalletModel, category: CategoryModel, subcategory: SubcategoryModel) {
        self.amount = entry.amount
        self.date = entry.date
        self.text = entry.text
        self.type = entry.type
        
        self.wallet = wallet
        self.category = category
        self.subcategory = subcategory
        
        super.init(properties: entry.properties)
    }
    
    override func manageConnectionsAndSave(forEntity entity: WalletEntry, inContext context: NSManagedObjectContext) throws -> WalletEntry {
        guard let categoryId = self.category.id,
            let subcategoryId = self.subcategory.id,
            let walletId = self.wallet.id
            else {
            fatalError("Every WalletEntry have to have category and subcategory ids!")
        }
        
        let categoryRequest: NSFetchRequest<Category> = Category.fetchRequest(forId: categoryId)
        let subcategoryRequest: NSFetchRequest<Subcategory> = Subcategory.fetchRequest(forId: subcategoryId)
        let walletRequest: NSFetchRequest<Wallet> = Wallet.fetchRequest(forId: walletId)
        
        guard let category: Category = try context.fetch(categoryRequest).first,
            let subcategory: Subcategory = try context.fetch(subcategoryRequest).first,
            let wallet: Wallet = try context.fetch(walletRequest).first
            else {
                fatalError("Category must exist at this point")
        }
        
        wallet.addToEntries(entity)
        category.addToEntries(entity)
        subcategory.addToEntries(entity)
        
        entity.date = self.date
        
        try context.save()
        
        return entity
    }
}

