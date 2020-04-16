//
//  WalletConfigurator.swift
//  Shekly-generated
//
//  Created by Patryk Mieszała on 16/04/2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Domain
import CleanArchitectureHelpers
import CommonUI

public protocol WalletConfiguratorProtocol {
    func configureWalletModule() -> UIViewController
}

public final class WalletConfigurator: Configurator, WalletConfiguratorProtocol {
    public func configureWalletModule() -> UIViewController {
        guard let viewController = R.storyboard.wallet.walletViewController() else {
            fatalError("VC can't be nil")
        }

        let presenter = WalletPresenter(viewController: viewController)
        let interactor = WalletInteractor(presenter: presenter,
                                          walletRepository: container.forceResolve(),
                                          walletEntriesRepository: container.forceResolve(),
                                          differ: container.forceResolve(),
                                          currencyFormatter: container.forceResolve(),
                                          userProvider: container.forceResolve())
        let router = WalletRouter(viewController: viewController, dataStore: interactor)

        viewController.interactor = interactor
        viewController.router = router
        viewController.tabBarItem.title = "Portfel"
        viewController.tabBarItem.image = CommonUI.R.image.tabBarWalletIcon()?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = CommonUI.R.image.tabBarWalletIcon()
        
        let walletNavigation = SheklyNavigationController(rootViewController: viewController)
        walletNavigation.setViewControllers([viewController], animated: false)
        walletNavigation.setNavigationBarHidden(true, animated: false)

        return walletNavigation
    }
}
