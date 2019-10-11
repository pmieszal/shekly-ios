//
//  WalletModel.swift
//  Database
//
//  Created by Patryk Mieszała on 23/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import CoreData

public class WalletModel: DatabaseModel<Wallet> {
    
    public let name: String?
    public let categoryIds: [String]
    public let subcategoryIds: [String]
    public let entriesIds: [String]
    
    public init(name: String, properties: DatabaseModelProperties?) {
        self.name = name
        categoryIds = []
        subcategoryIds = []
        entriesIds = []
        
        super.init(properties: properties)
    }
    
    required init(entity: Wallet) {
        name = entity.name
        categoryIds = entity.categoriesSet.compactMap { $0.id }
        subcategoryIds = entity.subcategoriesSet.compactMap { $0.id }
        entriesIds = entity.entriesSet.compactMap { $0.id }
        
        super.init(entity: entity)
    }
    
    init?(wallet: Wallet?) {
        guard let wallet = wallet else {
            return nil
        }
        name = wallet.name
        categoryIds = wallet.categoriesSet.compactMap { $0.id }
        subcategoryIds = wallet.subcategoriesSet.compactMap { $0.id }
        entriesIds = wallet.entriesSet.compactMap { $0.id }
        
        super.init(entity: wallet)
    }
}
