import Dip

public extension DependencyContainer {
    func configureWallet() -> DependencyContainer {
        unowned let container = self
        
        container.register(factory: { WalletConfigurator() })
        
        return container
    }
}
