//
//  SubcategoryModel.swift
//  Database
//
//  Created by Patryk Mieszała on 13/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import CoreData

public class SubcategoryModel: DatabaseModel<Subcategory> {
    
    public let name: String?
    public let walletId: String?
    public let categoryId: String?
    public let entriesIds: [String]
    
    public init(name: String?, category: CategoryModel?, properties: DatabaseModelProperties?) {
        self.name = name
        walletId = category?.walletId
        categoryId = category?.id
        entriesIds = []
        
        super.init(properties: properties)
    }
    
    required init(entity: Subcategory) {
        name = entity.name
        walletId = entity.wallet?.id
        categoryId = entity.category?.id
        entriesIds = entity.entriesSet.compactMap { $0.id }
        
        super.init(entity: entity)
    }
    
    override func manageConnectionsAndSave(forEntity entity: Subcategory, inContext context: NSManagedObjectContext) throws -> Subcategory {
        guard let categoryId = categoryId, let walletId = walletId else {
            fatalError("Every Subcategory have to have category/wallet id!")
        }
        
        let categoryRequest: NSFetchRequest<Category> = Category.fetchRequest(forId: categoryId)
        
        guard let category: Category = try context.fetch(categoryRequest).first else {
            fatalError("Category must exist at this point")
        }
        
        category.addToSubcategories(entity)
        
        let walletRequest: NSFetchRequest<Wallet> = Wallet.fetchRequest(forId: walletId)
        
        guard let wallet: Wallet = try context.fetch(walletRequest).first else {
            fatalError("Wallet must exist at this point")
        }
        
        wallet.addToSubcategories(entity)
        
        try context.save()
        
        return entity
    }
}

