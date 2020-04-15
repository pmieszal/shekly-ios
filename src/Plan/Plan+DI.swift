import Dip

public extension DependencyContainer {
    func configurePlan() -> DependencyContainer {
        unowned let container = self
        
        container.register(factory: { PlanConfigurator() })
        
        return container
    }
}
