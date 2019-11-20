//
//  WalletListViewModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 07/04/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Database
import User

public class WalletListViewModel: ViewModel {
    // MARK: - Internal properties
    var wallets: [WalletModel] = []
    weak var presenter: WalletListPresenter?
    weak var delegate: WalletListDelegate?
    var dataController: SheklyDataController
    
    // MARK: - Constructor
    init(
        presenter: WalletListPresenter,
        delegate: WalletListDelegate,
        dataController: SheklyDataController
        ) {
        self.presenter = presenter
        self.delegate = delegate
        self.dataController = dataController
    }
    
    public func viewDidLoad() {
        wallets = dataController.getWallets()
        presenter?.reloadList()
    }
    
    public func numberOfSections() -> Int {
        return 1
    }
    
    public func numberOfRows(inSection section: Int) -> Int {
        return wallets.count
    }
    
    public func title(forRowAt indexPath: IndexPath) -> String? {
        return wallets[indexPath.row].name
    }
    
    public func didSelect(itemAt indexPath: IndexPath) {
        guard let wallet = wallets[safe: indexPath.row] else {
            return
        }
        
        delegate?.didSelect(wallet: wallet)
    }
}
