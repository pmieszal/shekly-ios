//
//  MainConfigurator.swift
//  UI
//
//  Created by Patryk Mieszała on 15/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

public final class MainConfigurator: Configurator {
    
    public func configureMainModule(with window: UIWindow) -> MainRouter {
        let router: MainRouter = container.forceResolve(arguments: window)
        router.showTabs()
        
        return router
    }
}
