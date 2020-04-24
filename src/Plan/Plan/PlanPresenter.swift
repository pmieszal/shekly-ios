import UIKit

protocol PlanPresenterLogic {}

final class PlanPresenter {
    // MARK: - Private Properties
    private weak var viewController: PlanViewControllerLogic?
    
    // MARK: - Initializers
    init(viewController: PlanViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension PlanPresenter: PlanPresenterLogic {}
