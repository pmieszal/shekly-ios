import Dip
import AppRoutes
import CleanArchitectureHelpers

public extension DependencyContainer {
    func configureNewEntry() -> DependencyContainer {
        unowned let container = self
        
        container
            .register(.unique, factory: { NewEntryConfigurator() })
            .implements(Configurator.self,
                        tag: AppRoutes.newEntry)
        
        return container
    }
}
