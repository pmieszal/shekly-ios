import CleanArchitectureHelpers
import CommonUI
import Domain
import UIKit

public enum WalletDependency: String {
    case delegate
}

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
        viewController.tabBarItem.title = CommonUI.R.string.localizable.wallet_tab_title()
        viewController.tabBarItem.image = CommonUI.R.image.tabBarWalletIcon()?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = CommonUI.R.image.tabBarWalletIcon()
        
        let navigation = SheklyNavigationController(rootViewController: viewController)
        navigation.navigationBar.barTintColor = .systemBackground
        navigation.navigationBar.shadowImage = UIImage()
        navigation.setViewControllers([viewController], animated: false)
        
        return navigation
    }
}
