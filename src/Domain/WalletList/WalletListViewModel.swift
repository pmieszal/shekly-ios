//
//  WalletListViewModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 07/04/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Database
import User

public protocol WalletListPresenter: AnyObject {
    func reloadList()
}

public protocol WalletListDelegate: AnyObject {
    func didSelect(wallet: WalletModel)
}

public class WalletListViewModel: SheklyViewModel {
    
    // MARK: - Private properties
    private var wallets: [WalletModel]
    private weak var presenter: WalletListPresenter?
    private weak var delegate: WalletListDelegate?
    
    // MARK: - Constructor
    init(
        presenter: WalletListPresenter,
        delegate: WalletListDelegate,
        dataController: SheklyDataController
        ) {
        self.wallets = dataController.getWallets()
        self.presenter = presenter
        self.delegate = delegate
        
        super.init()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let wallet = wallets[indexPath.row]
        
        delegate?.didSelect(wallet: wallet)
    }
}
