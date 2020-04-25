import CleanArchitectureHelpers
import Common
import Domain

final class TabRouter {
    weak var viewController: SheklyTabBarController?
    
    let newEntryConfigurator: Configurator
    
    init(viewController: SheklyTabBarController,
         newEntryConfigurator: Configurator) {
        self.viewController = viewController
        self.newEntryConfigurator = newEntryConfigurator
    }
}

extension TabRouter {
    @objc
    func navigateToNewEntry() {
        let newEntry = newEntryConfigurator.configureModule()
        newEntry.presentationController?.delegate = viewController?.selectedViewController
        
        viewController?.present(newEntry, animated: true, completion: nil)
    }
}
