import CleanArchitectureHelpers
import Domain

public protocol WalletListConfiguratorProtocol {
    func configureWalletListModule(with delegate: WalletListDelegate) -> UIViewController
}

class WalletListConfigurator: Configurator, WalletListConfiguratorProtocol {
    func configureWalletListModule(with delegate: WalletListDelegate) -> UIViewController {
        guard let viewController = R.storyboard.walletList.walletListViewController() else {
            fatalError("VC can't be nil")
        }
        
        let presenter = WalletListPresenter(viewController: viewController)
        let interactor = WalletListInteractor(
            presenter: presenter,
            delegate: delegate)
        let router = WalletListRouter(
            viewController: viewController,
            dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
        
        return viewController
    }
}
