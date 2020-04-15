//
//  Domain+DI.swift
//  Domain
//
//  Created by Patryk Mieszała on 11/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Dip

public extension DependencyContainer {
    func configureDomain() -> DependencyContainer {
        unowned let container = self
        
        return container
    }
}
