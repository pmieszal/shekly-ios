//
//  WalletConfigurator.swift
//  UI
//
//  Created by Patryk Mieszała on 15/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Domain
import CleanArchitectureHelpers
import CommonUI

public final class WalletConfigurator: Configurator {
    public func configureWalletModule() -> UIViewController {
        guard let viewController = R.storyboard.wallet.walletViewController() else {
            fatalError("VC can't be nil")
        }
        
        let walletRouter = WalletRouter(viewController: viewController)
        let walletViewModel = WalletViewModel(
            presenter: viewController,
            walletRepository: container.forceResolve(),
            walletEntriesRepository: container.forceResolve(),
            differ: container.forceResolve(),
            currencyFormatter: container.forceResolve(),
            userProvider: container.forceResolve())
        
        viewController.set(viewModel: walletViewModel)
        viewController.router = walletRouter
        viewController.tabBarItem.title = "Portfel"
        viewController.tabBarItem.image = CommonUI.R.image.tabBarWalletIcon()?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = CommonUI.R.image.tabBarWalletIcon()
        
        let walletNavigation = SheklyNavigationController(rootViewController: viewController)
        walletNavigation.setViewControllers([viewController], animated: false)
        walletNavigation.setNavigationBarHidden(true, animated: false)
        
        return walletNavigation
    }
}
