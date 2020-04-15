import Dip

public extension DependencyContainer {
    func configureMain() -> DependencyContainer {
        unowned let container = self
        
        container.register(.unique, factory: { MainConfigurator() })
        
        return container
    }
}

