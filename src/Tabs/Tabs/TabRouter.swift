//
//  TabRouter.swift
//  UI
//
//  Created by Patryk Mieszała on 14/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Domain
import User
import Common
import NewEntry
import CleanArchitectureHelpers

final class TabRouter: Router {
    weak var viewController: SheklyTabBarController?
    
    init(viewController: SheklyTabBarController) {
        self.viewController = viewController
    }
}

extension TabRouter {
    @objc
    func navigateToNewEntry() {
        let configurator: NewEntryConfigurator = container.forceResolve()
        let newEntry = configurator.configureNewEntryModule()
        newEntry.presentationController?.delegate = viewController?.selectedViewController
        
        viewController?.present(newEntry, animated: true, completion: nil)
    }
}
