import UIKit

typealias WalletRouterType = WalletRouterProtocol & WalletDataPassing

@objc protocol WalletRouterProtocol {}

protocol WalletDataPassing {
    var dataStore: WalletDataStore { get }
}

final class WalletRouter: WalletDataPassing {
    // MARK: - Public Properties
    
    weak var viewController: WalletViewController?
    var dataStore: WalletDataStore
    
    // MARK: - Initializers
    
    init(viewController: WalletViewController?, dataStore: WalletDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}

extension WalletRouter: WalletRouterProtocol {}
