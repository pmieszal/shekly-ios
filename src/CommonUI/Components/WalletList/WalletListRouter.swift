import UIKit

typealias WalletListRouterType = WalletListRouterProtocol & WalletListDataPassing

@objc protocol WalletListRouterProtocol {}

protocol WalletListDataPassing {
    var dataStore: WalletListDataStore { get }
}

final class WalletListRouter: WalletListDataPassing {
    // MARK: - Public Properties
    
    weak var viewController: WalletListViewController?
    var dataStore: WalletListDataStore
    
    // MARK: - Initializers
    
    init(viewController: WalletListViewController?, dataStore: WalletListDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}

extension WalletListRouter: WalletListRouterProtocol {}
