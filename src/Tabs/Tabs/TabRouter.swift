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

final class TabRouter {
    weak var viewController: SheklyTabBarController?
    
    let newEntryConfigurator: NewEntryConfiguratorProtocol
    
    init(viewController: SheklyTabBarController,
         newEntryConfigurator: NewEntryConfiguratorProtocol) {
        self.viewController = viewController
        self.newEntryConfigurator = newEntryConfigurator
    }
}

extension TabRouter {
    @objc
    func navigateToNewEntry() {
        let newEntry = newEntryConfigurator.configureNewEntryModule()
        newEntry.presentationController?.delegate = viewController?.selectedViewController
        
        viewController?.present(newEntry, animated: true, completion: nil)
    }
}
