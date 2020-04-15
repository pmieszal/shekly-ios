//
//  User+DI.swift
//  User
//
//  Created by Patryk Mieszała on 11/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Dip

public extension DependencyContainer {
    func configureUser() -> DependencyContainer {
        unowned let container = self
        
        container.register(.singleton, factory: { UserProvider() }).implements(UserManaging.self)
        
        return container
    }
}
