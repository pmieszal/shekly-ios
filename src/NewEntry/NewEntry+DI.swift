import Dip

public extension DependencyContainer {
    func configureNewEntry() -> DependencyContainer {
        unowned let container = self
        
        container
            .register(.unique, factory: { NewEntryConfigurator() })
            .implements(NewEntryConfiguratorProtocol.self)
        
        return container
    }
}
