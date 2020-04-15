//
//  PlanConfigurator.swift
//  UI
//
//  Created by Patryk Mieszała on 15/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Domain
import CleanArchitectureHelpers
import CommonUI

public final class PlanConfigurator: Configurator {
    public func configurePlanModule() -> UIViewController {
        guard let viewController = R.storyboard.plan.planViewController() else {
            fatalError("VC can't be nil")
        }
        
        let router = PlanRouter(
            viewController: viewController,
            categoryConfigurator: container.forceResolve())
        viewController.router = router
        viewController.tabBarItem.title = "Plan"
        viewController.tabBarItem.image = CommonUI.R.image.tabBarPlanIcon()?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = CommonUI.R.image.tabBarPlanIcon()
        
        let planViewModel = PlanViewModel(presenter: viewController, userProvider: container.forceResolve())
        viewController.set(viewModel: planViewModel)
        
        let nvc = SheklyNavigationController(rootViewController: viewController)
        nvc.setNavigationBarHidden(true, animated: false)
        
        return nvc
    }
}
