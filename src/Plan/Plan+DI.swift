import Dip
import AppRoutes
import CleanArchitectureHelpers

public extension DependencyContainer {
    func configurePlan() -> DependencyContainer {
        unowned let container = self
        
        container.register(factory: { PlanConfigurator() })
            .implements(Configurator.self,
            tag: AppRoutes.plan)
        
        return container
    }
}
