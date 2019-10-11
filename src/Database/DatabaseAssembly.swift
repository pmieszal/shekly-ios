//
//  DatabaseAssembly.swift
//  Database
//
//  Created by Patryk Mieszała on 11/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Swinject

public class DatabaseAssembly: Assembly {
    public init() { }
    
    public func assemble(container: Container) {
        container.register(SheklyDatabasePersistance.self, factory: { _ in SheklyDatabasePersistance() })
            .inObjectScope(.container)
        
        container.register(SheklyDataController.self,
                           factory: { r in
                            SheklyDataController(store: r.forceResolve())
        })
        
        container.register(SheklyJSONDataController.self,
                           factory: { r in
                            SheklyJSONDataController(store: r.forceResolve())
        })
        
        container.register(SheklyJSONImporter.self,
                           factory: { r in
                            SheklyJSONImporter(dataController: r.forceResolve())
        })
    }
}
