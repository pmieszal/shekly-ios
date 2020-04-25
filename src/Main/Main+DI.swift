import Dip
import CleanArchitectureHelpers
import AppRoutes

public extension DependencyContainer {
    func configureMain() -> DependencyContainer {
        unowned let container = self
        
        container.register(.unique, factory: { MainConfigurator() })
            .implements(Configurator.self, tag: AppRoutes.main)
        
        return container
    }
}
