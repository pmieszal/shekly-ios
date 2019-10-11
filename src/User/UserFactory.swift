//
//  UserFactory.swift
//  User
//
//  Created by Patryk Mieszała on 03/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

public struct UserFactory {
    
    public init() { }
    
    public func getUserProvider() -> UserManaging {
        return UserProvider()
    }
}
