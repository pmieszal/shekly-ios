import CleanArchitectureHelpers
import Domain
import UIKit

protocol WalletListPresenterLogic: PresenterLogic {
    func reload(wallets: [WalletModel])
}

final class WalletListPresenter {
    // MARK: - Private Properties
    
    private weak var viewController: WalletListViewControllerLogic?
    
    // MARK: - Initializers
    
    init(viewController: WalletListViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension WalletListPresenter: WalletListPresenterLogic {
    var viewControllerLogic: ViewControllerLogic? {
        viewController
    }
    
    func reload(wallets: [WalletModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<String, String?>()
        snapshot.appendSections(["wallets"])
        
        let names = wallets.map { $0.name }
        snapshot.appendItems(names)
        
        viewController?.reloadList(snapshot: snapshot)
    }
}
