//
//  Database+DI.swift
//  Database
//
//  Created by Patryk Mieszała on 11/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Dip

public extension DependencyContainer {
    func configureDatabase() -> DependencyContainer {
        unowned let container = self
        
        container.register(.singleton, factory: { SheklyDatabasePersistance() as SheklyDatabaseStore })
        
        container.register(.shared,
                           factory: {
                            SheklyDataRepository(store: container.forceResolve())
            })
            .implements(SheklyDataController.self)
        
        container.register(.shared,
                           factory: {
                            SheklyJSONDataController(store: container.forceResolve())
        })
        
        container.register(.shared,
                           factory: {
                            SheklyJSONImporter(dataController: container.forceResolve())
        })
        
        return container
    }
}
