import Dip
import AppRoutes
import CleanArchitectureHelpers

public extension DependencyContainer {
    func configureTabs() -> DependencyContainer {
        unowned let container = self
        
        container
            .register(factory: { TabConfigurator() })
            .implements(Configurator.self,
                        tag: AppRoutes.tabs)
        
        return container
    }
}
