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
        self.categoryIds = []
        self.subcategoryIds = []
        self.entriesIds = []
        
        super.init(properties: properties)
    }
    
    required init(entity: Wallet) {
        self.name = entity.name
        self.categoryIds = entity.categoriesSet.compactMap { $0.id }
        self.subcategoryIds = entity.subcategoriesSet.compactMap { $0.id }
        self.entriesIds = entity.entriesSet.compactMap { $0.id }
        
        super.init(entity: entity)
    }
    
    init?(wallet: Wallet?) {
        guard let wallet = wallet else { return nil }
        self.name = wallet.name
        self.categoryIds = wallet.categoriesSet.compactMap { $0.id }
        self.subcategoryIds = wallet.subcategoriesSet.compactMap { $0.id }
        self.entriesIds = wallet.entriesSet.compactMap { $0.id }
        
        super.init(entity: wallet)
    }
}
