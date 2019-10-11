//
//  UserAssembly.swift
//  User
//
//  Created by Patryk Mieszała on 11/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Swinject

public class UserAssembly: Assembly {
    public init() { }
    
    public func assemble(container: Container) {
        container.register(UserManaging.self, factory: { _ in UserProvider() })
            .inObjectScope(.container)
    }
}
