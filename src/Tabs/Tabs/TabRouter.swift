import CleanArchitectureHelpers
import Common
import Domain
import NewEntry
import User

final class TabRouter {
    weak var viewController: SheklyTabBarController?
    
    let newEntryConfigurator: NewEntryConfiguratorProtocol
    
    init(viewController: SheklyTabBarController,
         newEntryConfigurator: NewEntryConfiguratorProtocol) {
        self.viewController = viewController
        self.newEntryConfigurator = newEntryConfigurator
    }
}

extension TabRouter {
    @objc
    func navigateToNewEntry() {
        let newEntry = newEntryConfigurator.configureNewEntryModule()
        newEntry.presentationController?.delegate = viewController?.selectedViewController
        
        viewController?.present(newEntry, animated: true, completion: nil)
    }
}
