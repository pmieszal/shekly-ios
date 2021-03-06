import CleanArchitectureHelpers
import CommonUI
import Domain
import UIKit

final class WalletConfigurator: Configurator {
    override func configureModule(withDependencies dependencies: [String: Any] = [:]) -> UIViewController {
        guard let viewController = R.storyboard.wallet.walletViewController() else {
            fatalError("VC can't be nil")
        }
        
        let presenter = WalletPresenter(viewController: viewController)
        let interactor = WalletInteractor(
            presenter: presenter,
            getWalletsUseCase: container.forceResolve(),
            saveWalletUseCase: container.forceResolve(),
            getEntriesUseCase: container.forceResolve(),
            deleteWalletEntryUseCase: container.forceResolve(),
            setSessionWalletUseCase: container.forceResolve(),
            currencyFormatter: container.forceResolve())
        let router = WalletRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
        viewController.tabBarItem.title = "Portfel"
        viewController.tabBarItem.image = CommonUI.R.image.tabBarWalletIcon()?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = CommonUI.R.image.tabBarWalletIcon()
        
        let walletNavigation = SheklyNavigationController(rootViewController: viewController)
        walletNavigation.setViewControllers([viewController], animated: false)
        walletNavigation.setNavigationBarHidden(true, animated: false)
        
        return walletNavigation
    }
}
