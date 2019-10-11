//
//  CategoryModel.swift
//  Database
//
//  Created by Patryk Mieszała on 13/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import CoreData

public class CategoryModel: DatabaseModel<Category> {
    
    public let name: String?
    public let walletId: String?
    public let subcategoryIds: [String]
    public let entriesIds: [String]
    public let amount: Double
    
    public init(name: String?, walletId: String?, properties: DatabaseModelProperties?) {
        self.name = name
        self.walletId = walletId
        self.subcategoryIds = []
        self.entriesIds = []
        self.amount = 0
        
        super.init(properties: properties)
    }
    
    required init(entity: Category) {
        name = entity.name
        walletId = entity.wallet?.id
        subcategoryIds = entity.subcategoriesSet.compactMap { $0.id }
        entriesIds = entity.entriesSet.compactMap { $0.id }
        amount = entity.entriesSet.reduce(0) { $0 + $1.amount }
        
        super.init(entity: entity)
    }
    
    init?(category: Category?) {
        guard let category = category else {
            return nil
        }
        name = category.name
        walletId = category.wallet?.id
        subcategoryIds = category.subcategoriesSet.compactMap { $0.id }
        entriesIds = category.entriesSet.compactMap { $0.id }
        amount = category.entriesSet.reduce(0) { $0 + $1.amount }
        
        super.init(entity: category)
    }
    
    override func manageConnectionsAndSave(forEntity entity: Category, inContext context: NSManagedObjectContext) throws -> Category {
        
        guard let walletId = walletId else {
            fatalError("Every category have to have wallet id!")
        }
        
        let walletRequest: NSFetchRequest<Wallet> = Wallet.fetchRequest(forId: walletId)
        
        guard let wallet: Wallet = try context.fetch(walletRequest).first else {
            fatalError("Wallet must exist at this point")
        }
        
        wallet.addToCategories(entity)
        
        try context.save()
        
        return entity
    }
}
