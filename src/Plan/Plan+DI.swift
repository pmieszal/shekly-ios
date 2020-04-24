import Dip

public extension DependencyContainer {
    func configurePlan() -> DependencyContainer {
        unowned let container = self
        
        container.register(factory: { PlanConfigurator() }).implements(PlanConfiguratorProtocol.self)
        
        return container
    }
}
