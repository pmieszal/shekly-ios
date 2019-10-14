//
//  User+DI.swift
//  User
//
//  Created by Patryk Mieszała on 11/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Dip

public extension DependencyContainer {
    static func configureUser() -> DependencyContainer {
        return DependencyContainer { container in
            container.register(.singleton, factory: { _ in UserProvider() as UserManaging })
        }
    }
}
