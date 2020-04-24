import Dip

public extension DependencyContainer {
    func configureTabs() -> DependencyContainer {
        unowned let container = self
        
        container.register(factory: { TabConfigurator() })
        
        return container
    }
}
