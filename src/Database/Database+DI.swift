//
//  Database+DI.swift
//  Database
//
//  Created by Patryk Mieszała on 11/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Dip
import Domain
import Common
import RealmSwift

public extension DependencyContainer {
    func configureDatabase() -> DependencyContainer {
        unowned let container = self
        
        container.register(factory: { try Realm() })
        
        container.register(
            .shared,
            factory: {
                DBWalletWorker(realm: container.forceResolve())
            })
            .implements(WalletRepository.self)
        
        container.register(
            .shared,
            factory: {
                DBCategoryWorker(
                    realm: container.forceResolve(),
                    walletWorker: container.forceResolve())
            })
            .implements(CategoryRepository.self)
        
        container.register(
            .shared,
            factory: {
                DBSubcategoryWorker(
                    realm: container.forceResolve(),
                    walletWorker: container.forceResolve(),
                    categoryWorker: container.forceResolve())
            })
            .implements(SubcategoryRepository.self)
        
        container.register(
            .shared,
            factory: {
                DBWalletEntryWorker(
                    realm: container.forceResolve(),
                    walletWorker: container.forceResolve(),
                    categoryWorker: container.forceResolve(),
                    subcategoryWorker: container.forceResolve())
            })
            .implements(WalletEntriesRepository.self)
        
        container.register(
            .shared,
            factory: {
                SheklyJSONImporter(
                    dataController: SheklyJSONDataController(
                        walletWorker: container.forceResolve(),
                        categoryWorker: container.forceResolve(),
                        subcategoryWorker: container.forceResolve(),
                        entryWorker: container.forceResolve())
                )
            })
        
        return container
    }
}
