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

public final class MainRouter {
    weak var navigationController: UINavigationController?
    
    let window: UIWindow
    let tabConfigurator: TabConfigurator
    
    init(window: UIWindow,
         tabConfigurator: TabConfigurator) {
        self.window = window
        self.tabConfigurator = tabConfigurator
    }
}

extension MainRouter {
    func showTabs() {
        let navigation = SheklyNavigationController()
        navigation.setNavigationBarHidden(true, animated: false)
        
        let tabs = tabConfigurator.configureTabModule()
        navigation.setViewControllers([tabs], animated: false)
        
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        navigationController = navigation
    }
}
