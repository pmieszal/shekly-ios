import CleanArchitectureHelpers
import Domain
import User

public final class PlanRouter {
    private weak var viewController: PlanViewController?
    
    init(viewController: PlanViewController) {
        self.viewController = viewController
    }
}

extension PlanRouter {}
