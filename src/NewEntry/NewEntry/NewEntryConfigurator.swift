//
//  NewEntryConfigurator.swift
//  UI
//
//  Created by Patryk Mieszała on 15/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Domain

final class NewEntryConfigurator: Configurator {
    func configureNewEntryModule() -> UIViewController {
        guard let viewController = R.storyboard.newEntry.newEntryViewController() else {
            fatalError("VC can't be nil")
        }
        
        let router: NewEntryRouter = container.forceResolve(arguments: viewController)
        let viewModel: NewEntryViewModel = container.forceResolve(arguments: viewController as NewEntryPresenter)
        viewController.set(viewModel: viewModel)
        viewController.router = router
        
        return viewController
    }
}
