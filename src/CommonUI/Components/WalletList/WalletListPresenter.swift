//
//  WalletListPresenter.swift
//  Shekly-generated
//
//  Created by Patryk Mieszała on 18/04/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Domain
import CleanArchitectureHelpers

protocol WalletListPresenterLogic: PresenterLogic {
    func reload(wallets: [SheklyWalletModel])
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
    
    func reload(wallets: [SheklyWalletModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<String, String?>()
        snapshot.appendSections(["wallets"])
        
        let names = wallets.map { $0.name }
        snapshot.appendItems(names)
        
        viewController?.reloadList(snapshot: snapshot)
    }
}
