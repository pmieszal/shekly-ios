//
//  Shared+DI.swift
//  Shared
//
//  Created by Patryk Mieszała on 11/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Dip

public extension DependencyContainer {
    static func configureShared() -> DependencyContainer {
        return DependencyContainer { container in
            container.register(.shared, factory: { LocaleProvider() })
            container.register(.shared, factory: { NumberParser() })
        }
    }
}
