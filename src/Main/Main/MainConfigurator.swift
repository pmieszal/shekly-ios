import CleanArchitectureHelpers
import UIKit

public final class MainConfigurator: Configurator {
    public func configureMainModule(with window: UIWindow) -> MainRouter {
        let router = MainRouter(
            window: window,
            tabConfigurator: container.forceResolve())
        router.showTabs()
        
        return router
    }
}
