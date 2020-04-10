//
//  TabConfigurator.swift
//  UI
//
//  Created by Patryk Mieszała on 15/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Domain
import Common

class TabConfigurator: Configurator {
    func configureTabModule() -> SheklyTabBarController {
        let tabController = SheklyTabBarController()
        let tabRouter: TabRouter = container.forceResolve(arguments: tabController)
        tabController.router = tabRouter
        
        let walletConfigurator: WalletConfigurator = container.forceResolve()
        let walletViewController = walletConfigurator.configureWalletModule()
        
        let planConfigurator: PlanConfigurator = container.forceResolve()
        let planViewController = planConfigurator.configurePlanModule()
        
        class TempViewController: SheklyViewController<SheklyViewModel> { }
        
        //TODO: move configuration to configurators
        let stats = TempViewController()
        let statsViewModel: SheklyViewModel = container.forceResolve(tag: ContainerCustomName.emptyViewModel)
        stats.set(viewModel: statsViewModel)
        stats.view.backgroundColor = Colors.brandColor
        stats.tabBarItem.title = "Statystyki"
        stats.tabBarItem.image = R.image.tabBarStatsIcon()?.withRenderingMode(.alwaysOriginal)
        stats.tabBarItem.selectedImage = R.image.tabBarStatsIcon()
        
        let more = TempViewController()
        let moreViewModel: SheklyViewModel = container.forceResolve(tag: ContainerCustomName.emptyViewModel)
        more.set(viewModel: moreViewModel)
        more.view.backgroundColor = Colors.brandColor
        more.tabBarItem.title = "Więcej"
        more.tabBarItem.image = R.image.tabBarMoreIcon()?.withRenderingMode(.alwaysOriginal)
        more.tabBarItem.selectedImage = R.image.tabBarMoreIcon()
        
        let empty = UIViewController()
        
        tabController.setViewControllers([walletViewController, planViewController, empty, stats, more], animated: false)
        
        return tabController
    }
}
