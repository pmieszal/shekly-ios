//
//  Shared+DI.swift
//  Shared
//
//  Created by Patryk Mieszała on 11/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Dip
import Domain

public extension DependencyContainer {
    func configureCommon() -> DependencyContainer {
        unowned let container = self
        
        container.register(.unique, factory: { Differ() })
        container.register(.shared, factory: { LocaleProvider() })
        container.register(.shared, factory: { NumberParser() })
        container.register(
            .shared,
            factory: {
                CurrencyFormatter(
                    localeProvider: container.forceResolve(),
                    numberParser: container.forceResolve())
            })
            .implements(SheklyCurrencyFormatter.self)
        
        return container
    }
}
