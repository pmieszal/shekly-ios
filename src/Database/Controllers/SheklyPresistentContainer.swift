//
//  SheklyPresistentContainer.swift
//  Database
//
//  Created by Patryk Mieszała on 02/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import CoreData

class SheklyPresistentContainer: NSPersistentContainer {
    
    static let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.pl.patryk.mieszala.Shekly")!
    
    override class func defaultDirectoryURL() -> URL {
        return url
    }
}
