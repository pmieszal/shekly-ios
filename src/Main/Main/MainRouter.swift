import CleanArchitectureHelpers
import CommonUI
import UIKit

public final class MainRouter {
    weak var viewController: UIViewController?
    
    let window: UIWindow
    let viewConfigurator: Configurator
    
    init(window: UIWindow,
         viewConfigurator: Configurator) {
        self.window = window
        self.viewConfigurator = viewConfigurator
    }
}

extension MainRouter {
    func showTabs() {
        let navigation = SheklyNavigationController()
        navigation.setNavigationBarHidden(true, animated: false)
        
        let view = viewConfigurator.configureModule()
        
        window.rootViewController = view
        window.makeKeyAndVisible()
        viewController = view
    }
}
