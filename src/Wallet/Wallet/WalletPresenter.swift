//
//  WalletPresenter.swift
//  Shekly-generated
//
//  Created by Patryk Mieszała on 16/04/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import CleanArchitectureHelpers
import Domain

protocol WalletPresenterLogic: PresenterLogic {
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
    
    func reload(wallets: [WalletModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<String, WalletModel>()
        snapshot.appendSections(["wallets"])
        snapshot.appendItems(wallets)
        
        viewController?.reloadWallets(snapshot: snapshot)
    }
    
    func reload(entries: [WalletEntryCellModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<String, WalletEntryCellModel>()
        snapshot.appendSections(["entries"])
        snapshot.appendItems(entries)
        
        viewController?.reloadEntries(snapshot: snapshot)
    }
}
