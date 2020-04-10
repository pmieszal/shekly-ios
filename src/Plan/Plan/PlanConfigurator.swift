//
//  PlanConfigurator.swift
//  UI
//
//  Created by Patryk Mieszała on 15/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Domain

final class PlanConfigurator: Configurator {
    func configurePlanModule() -> UIViewController {
        guard let viewController = R.storyboard.plan.planViewController() else {
            fatalError("VC can't be nil")
        }
        
        let router: PlanRouter = container.forceResolve(arguments: viewController)
        viewController.router = router
        viewController.tabBarItem.title = "Plan"
        viewController.tabBarItem.image = R.image.tabBarPlanIcon()?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = R.image.tabBarPlanIcon()
        
        let planViewModel: PlanViewModel = container.forceResolve(arguments: viewController as PlanPresenter)
        viewController.set(viewModel: planViewModel)
        
        let nvc = SheklyNavigationController(rootViewController: viewController)
        nvc.setNavigationBarHidden(true, animated: false)
        
        return nvc
    }
}
