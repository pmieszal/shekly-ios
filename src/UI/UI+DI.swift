//
//  UI+DI.swift
//  UI
//
//  Created by Patryk Mieszała on 15/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Dip

public extension DependencyContainer {
    func configureUI() -> DependencyContainer {
        unowned let container = self
        
        container.register(.unique, factory: { MainConfigurator() })
        container.register(.unique, factory: { MainRouter(window: $0) })
        
        container.register(.unique, factory: { TabConfigurator() })
        container.register(.unique, factory: { TabRouter(viewController: $0) })
        
        container.register(.unique, factory: { WalletConfigurator() })
        container.register(.unique, factory: { WalletRouter(viewController: $0) })
        
        container.register(.unique, factory: { PlanConfigurator() })
        container.register(.unique, factory: { PlanRouter(viewController: $0) })
        
        container.register(.unique, factory: { CategoryConfigurator() })
        container.register(.unique, factory: { CategoryRouter(viewController: $0) })
        
        return container
    }
}
