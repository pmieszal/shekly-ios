import CleanArchitectureHelpers
import Domain
import UIKit
import SwiftDate

protocol WalletPresenterLogic: PresenterLogic {
    func display(wallet: WalletModel?)
    func reload(wallets: [WalletModel])
    func reload(entries: [WalletEntryCellModel])
}

final class WalletPresenter {
    // MARK: - Private Properties
    
    private weak var viewController: WalletViewControllerLogic?
    
    // MARK: - Initializers
    
    init(viewController: WalletViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension WalletPresenter: WalletPresenterLogic {
    var viewControllerLogic: ViewControllerLogic? {
        viewController
    }
    
    func display(wallet: WalletModel?) {
        viewController?.display(walletName: wallet?.name)
    }
    
    func reload(wallets: [WalletModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<String, WalletModel>()
        snapshot.appendSections(["wallets"])
        snapshot.appendItems(wallets)
        
        viewController?.reloadWallets(snapshot: snapshot)
    }
    
    func reload(entries: [WalletEntryCellModel]) {
        let sections: [Date: [WalletEntryCellModel]] = entries.reduce(into: [:]) { (dict, model) in
            let date = model.date.dateAtStartOf(.day)
            
            guard var section = dict[date] else {
                dict[date] = [model]
                return
            }
            
            section.append(model)
            dict[date] = section
        }
        
        let sortedSections = sections.sorted { $0.key > $1.key }
        var snapshot = NSDiffableDataSourceSnapshot<String, WalletEntryCellModel>()
        
        for section in sortedSections {
            let dateString = section.key.toString(DateToStringStyles.custom("EEEE, MMMM d"))
            snapshot.appendSections([dateString])
            snapshot.appendItems(section.value, toSection: dateString)
        }
        
        viewController?.reloadEntries(snapshot: snapshot)
    }
}
