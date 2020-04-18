import Dip

public extension DependencyContainer {
    //swiftlint:disable:next function_body_length
    func configureNewEntry() -> DependencyContainer {
        unowned let container = self
        
        container
            .register(.unique, factory: { NewEntryConfigurator() })
            .implements(NewEntryConfiguratorProtocol.self)
        
        return container
    }
}
