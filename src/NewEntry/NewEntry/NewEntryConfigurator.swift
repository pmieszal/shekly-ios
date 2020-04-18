//
//  NewEntryConfigurator.swift
//  Shekly-generated
//
//  Created by Patryk Mieszała on 17/04/2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import CleanArchitectureHelpers
import Domain

public protocol NewEntryConfiguratorProtocol {
    func configureNewEntryModule() -> UIViewController
}

class NewEntryConfigurator: Configurator, NewEntryConfiguratorProtocol {
    func configureNewEntryModule() -> UIViewController {
        guard let viewController = R.storyboard.newEntry.newEntryViewController() else {
            fatalError("VC can't be nil")
        }
        
        let presenter = NewEntryPresenter(viewController: viewController)
        let interactor = NewEntryInteractor(
            presenter: presenter,
            currencyFormatter: container.forceResolve(),
            differ: container.forceResolve(),
            numberParser: container.forceResolve(),
            userProvider: container.forceResolve())
        let router = NewEntryRouter(
            viewController: viewController,
            dataStore: interactor,
            walletConfigurator: container.forceResolve(),
            datePickerConfigurator: container.forceResolve())

        viewController.interactor = interactor
        viewController.router = router

        return viewController
    }
}
