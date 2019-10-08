//
//  DatabaseFactory.swift
//  Database
//
//  Created by Patryk Mieszała on 13/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

//This is internal variable only to be used in DatabaseModel when decoding objectID property.
//Stored globally in this place, since in future this can be overriden for test purposes.
internal var databaseFactory: DatabaseFactory = DatabaseFactory()

public struct DatabaseFactory {
    
    static let dataStore: SheklyDatabasePersistance = SheklyDatabasePersistance()
    static let dataController: SheklyDataController = SheklyDataController(store: dataStore)
    static let JSONDataController: SheklyJSONDataController = SheklyJSONDataController(store: dataStore)
    
    public init() { }
    
    public func getDataController() -> SheklyDataController {
        return DatabaseFactory.dataController
    }
    
    public func getJSONDataController() -> SheklyJSONDataController {
        return DatabaseFactory.JSONDataController
    }
    
    public func getSheklyJSONImporter() -> SheklyJSONImporter {
        return SheklyJSONImporter(dataController: getJSONDataController())
    }
}
