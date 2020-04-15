//
//  TabConfigurator.swift
//  UI
//
//  Created by Patryk Mieszała on 15/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Wallet
import Plan
import NewEntry
import Domain
import Common
import CommonUI
import CleanArchitectureHelpers

public class TabConfigurator: Configurator {
    public func configureTabModule() -> UIViewController {
        let tabController = SheklyTabBarController()
        let tabRouter = TabRouter(
            viewController: tabController,
            newEntryConfigurator: container.forceResolve())
        tabController.router = tabRouter
        
        let walletConfigurator: WalletConfigurator = container.forceResolve()
        let walletViewController = walletConfigurator.configureWalletModule()
        
        let planConfigurator: PlanConfigurator = container.forceResolve()
        let planViewController = planConfigurator.configurePlanModule()
        
        class TempViewController: SheklyViewController<SheklyViewModel> { }
        
        //TODO: move configuration to configurators
        let stats = TempViewController()
        let statsViewModel = SheklyViewModel()
        stats.set(viewModel: statsViewModel)
        stats.view.backgroundColor = Colors.brandColor
        stats.tabBarItem.title = "Statystyki"
        stats.tabBarItem.image = CommonUI.R.image.tabBarStatsIcon()?.withRenderingMode(.alwaysOriginal)
        stats.tabBarItem.selectedImage = CommonUI.R.image.tabBarStatsIcon()
        
        let more = TempViewController()
        let moreViewModel = SheklyViewModel()
        more.set(viewModel: moreViewModel)
        more.view.backgroundColor = Colors.brandColor
        more.tabBarItem.title = "Więcej"
        more.tabBarItem.image = CommonUI.R.image.tabBarMoreIcon()?.withRenderingMode(.alwaysOriginal)
        more.tabBarItem.selectedImage = CommonUI.R.image.tabBarMoreIcon()
        
        let empty = UIViewController()
        
        tabController.setViewControllers([walletViewController, planViewController, empty, stats, more], animated: false)
        
        return tabController
    }
}
