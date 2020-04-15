//
//  MainRouter.swift
//  UI
//
//  Created by Patryk Mieszała on 03/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import CleanArchitectureHelpers
import CommonUI
import Tabs

public final class MainRouter: Router {
    weak var navigationController: UINavigationController?
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
}

extension MainRouter {
    func showTabs() {
        let navigation = SheklyNavigationController()
        navigation.setNavigationBarHidden(true, animated: false)
        
        let tabConfigurator: TabConfigurator = container.forceResolve()
        let tabs = tabConfigurator.configureTabModule()
        
        navigation.setViewControllers([tabs], animated: false)
        
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        navigationController = navigation
    }
}
