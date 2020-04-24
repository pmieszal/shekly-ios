import UIKit

protocol PlanViewControllerLogic: AnyObject {}

final class PlanViewController: UIViewController {
    // MARK: - Public Properties
    
    var interactor: PlanInteractorLogic?
    var router: PlanRouterType?
}

extension PlanViewController: PlanViewControllerLogic {}
