import Dip
import AppRoutes
import CleanArchitectureHelpers

public extension DependencyContainer {
    func configureWallet() -> DependencyContainer {
        unowned let container = self
        
        container
            .register(factory: { WalletConfigurator() })
            .implements(Configurator.self,
                        tag: AppRoutes.wallet)
        
        
        return container
    }
}
