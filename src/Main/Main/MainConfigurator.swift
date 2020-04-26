import AppRoutes
import CleanArchitectureHelpers
import UIKit

public enum MainDependency: String {
    case window
}

final class MainConfigurator: Configurator {
    override func configureModule(withDependencies dependencies: [String: Any] = [:]) -> UIViewController {
        guard let window = dependencies[MainDependency.window.rawValue] as? UIWindow else {
            fatalError("Provide window")
        }
        
        let router = MainRouter(
            window: window,
            viewConfigurator: container.forceResolve(tag: AppRoutes.wallet))
        
        return router.start()
    }
}
