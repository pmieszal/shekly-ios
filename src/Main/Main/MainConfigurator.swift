import AppRoutes
import CleanArchitectureHelpers
import UIKit

public final class MainConfigurator: Configurator {
    public func configureMainModule(with window: UIWindow) -> MainRouter {
        let router = MainRouter(
            window: window,
            viewConfigurator: container.forceResolve(tag: AppRoutes.wallet))
        router.showTabs()
        
        return router
    }
}
