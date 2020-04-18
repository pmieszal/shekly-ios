//
//  WalletListInteractor.swift
//  Shekly-generated
//
//  Created by Patryk Mieszała on 18/04/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Domain
import CleanArchitectureHelpers

protocol WalletListInteractorLogic: InteractorLogic {
    func didSelect(itemAt indexPath: IndexPath)
}

protocol WalletListDataStore {}

final class WalletListInteractor: WalletListDataStore {
    // MARK: - Public Properties
    var presenter: WalletListPresenterLogic
    
    // MARK: - Private properties
    private var wallets: [SheklyWalletModel]
    private weak var delegate: WalletListDelegate?

    // MARK: - Initializers
    init(presenter: WalletListPresenterLogic,
         delegate: WalletListDelegate) {
      self.presenter = presenter
      self.wallets = [] // dataController.getWallets()
      self.presenter = presenter
      self.delegate = delegate
    }
}

extension WalletListInteractor: WalletListInteractorLogic {
    func viewDidLoad() {
        presenter.reload(wallets: wallets)
    }
    
    func didSelect(itemAt indexPath: IndexPath) {
        let wallet = wallets[indexPath.row]
        
        delegate?.didSelect(wallet: wallet)
    }
}
