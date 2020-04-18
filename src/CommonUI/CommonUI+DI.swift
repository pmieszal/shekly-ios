import Dip

public extension DependencyContainer {
    func configureCommonUI() -> DependencyContainer {
        unowned let container = self
        
        container.register(factory: { WalletListConfigurator() })
        container.register(factory: { DatePickerConfigurator() }).implements(DatePickerConfiguratorProtocol.self)
        
        return container
    }
}
