//
//  Database+DI.swift
//  Database
//
//  Created by Patryk Mieszała on 11/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Dip

public extension DependencyContainer {
    static func configureDatabase() -> DependencyContainer {
        return DependencyContainer { container in
            container.register(.singleton, factory: { SheklyDatabasePersistance() })
            
            container.register(.shared,
                               factory: {
                                SheklyDataController(store: container.forceResolve())
            })
            
            container.register(.shared,
                               factory: {
                                SheklyJSONDataController(store: container.forceResolve())
            })
            
            container.register(.shared,
                               factory: {
                                SheklyJSONImporter(dataController: container.forceResolve())
            })
        }
    }
}
