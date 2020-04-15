//
//  NewEntryConfigurator.swift
//  UI
//
//  Created by Patryk Mieszała on 15/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import CleanArchitectureHelpers
import Domain

public final class NewEntryConfigurator: Configurator {
    public func configureNewEntryModule() -> UIViewController {
        guard let viewController = R.storyboard.newEntry.newEntryViewController() else {
            fatalError("VC can't be nil")
        }
        
        let router = NewEntryRouter(viewController: viewController)
        let viewModel = NewEntryViewModel(
            presenter: viewController,
            currencyFormatter: container.forceResolve(),
            differ: container.forceResolve(),
            numberParser: container.forceResolve(),
            userProvider: container.forceResolve())
        viewController.set(viewModel: viewModel)
        viewController.router = router
        
        return viewController
    }
}
