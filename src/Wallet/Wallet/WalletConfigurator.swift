//
//  WalletConfigurator.swift
//  UI
//
//  Created by Patryk Mieszała on 15/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Domain

final class WalletConfigurator: Configurator {
    func configureWalletModule() -> UIViewController {
        guard let viewController = R.storyboard.wallet.walletViewController() else {
            fatalError("VC can't be nil")
        }
        
        let walletRouter: WalletRouter = container.forceResolve(arguments: viewController)
        let walletViewModel: WalletViewModel = container.forceResolve(arguments: viewController as WalletPresenter)
        viewController.set(viewModel: walletViewModel)
        viewController.router = walletRouter
        viewController.tabBarItem.title = "Portfel"
        viewController.tabBarItem.image = R.image.tabBarWalletIcon()?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = R.image.tabBarWalletIcon()
        
        let walletNavigation = SheklyNavigationController(rootViewController: viewController)
        walletNavigation.setViewControllers([viewController], animated: false)
        walletNavigation.setNavigationBarHidden(true, animated: false)
        
        return walletNavigation
    }
}
