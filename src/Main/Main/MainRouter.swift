import CleanArchitectureHelpers
import CommonUI
import UIKit

public final class MainRouter {
    weak var navigationController: UINavigationController?
    
    let window: UIWindow
    let tabConfigurator: Configurator
    
    init(window: UIWindow,
         tabConfigurator: Configurator) {
        self.window = window
        self.tabConfigurator = tabConfigurator
    }
}

extension MainRouter {
    func showTabs() {
        let navigation = SheklyNavigationController()
        navigation.setNavigationBarHidden(true, animated: false)
        
        let tabs = tabConfigurator.configureModule()
        navigation.setViewControllers([tabs], animated: false)
        
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        navigationController = navigation
    }
}
