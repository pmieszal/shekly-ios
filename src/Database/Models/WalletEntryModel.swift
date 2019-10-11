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
        amount = entity.amount
        date = entity.date
        text = entity.text
        type = WalletEntryType(rawValue: entity.type)!
        
        wallet = WalletModel(entity: entity.wallet!)
        category = CategoryModel(entity: entity.category!)
        subcategory = SubcategoryModel(entity: entity.subcategory!)
        
        super.init(entity: entity)
    }
    
    init(entry: WalletEntryModel, wallet: WalletModel, category: CategoryModel, subcategory: SubcategoryModel) {
        amount = entry.amount
        date = entry.date
        text = entry.text
        type = entry.type
        
        self.wallet = wallet
        self.category = category
        self.subcategory = subcategory
        
        super.init(properties: entry.properties)
    }
    
    override func manageConnectionsAndSave(forEntity entity: WalletEntry, inContext context: NSManagedObjectContext) throws -> WalletEntry {
        guard let categoryId = category.id,
            let subcategoryId = subcategory.id,
            let walletId = wallet.id
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
        
        entity.date = date
        
        try context.save()
        
        return entity
    }
}
