import Dip

public extension DependencyContainer {
    func configureCategory() -> DependencyContainer {
        unowned let container = self
        
        container.register(factory: { CategoryConfigurator() })
        
        return container
    }
}
