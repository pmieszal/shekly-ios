import CleanArchitectureHelpers
import CommonUI
import Domain
import UIKit

public protocol PlanConfiguratorProtocol {
    func configurePlanModule() -> UIViewController
}

class PlanConfigurator: Configurator, PlanConfiguratorProtocol {
    func configurePlanModule() -> UIViewController {
        guard let viewController = R.storyboard.plan.planViewController() else {
            fatalError("VC can't be nil")
        }
        
        let presenter = PlanPresenter(viewController: viewController)
        let interactor = PlanInteractor(presenter: presenter)
        let router = PlanRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
        
        viewController.tabBarItem.title = "Plan"
        viewController.tabBarItem.image = CommonUI.R.image.tabBarPlanIcon()?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = CommonUI.R.image.tabBarPlanIcon()
        
        return viewController
    }
}
