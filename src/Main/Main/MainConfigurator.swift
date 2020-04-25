import CleanArchitectureHelpers
import UIKit
import AppRoutes

public final class MainConfigurator: Configurator {
    public func configureMainModule(with window: UIWindow) -> MainRouter {
        let router = MainRouter(
            window: window,
            tabConfigurator: container.forceResolve(tag: AppRoutes.tabs))
        router.showTabs()
        
        return router
    }
}
