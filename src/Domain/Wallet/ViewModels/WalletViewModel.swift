//
//  WalletViewModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 05/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import User
import SHTokenField
import Database
import Shared

public protocol WalletPresenter: ReloadablePresenter {
    func reloadWallets()
}

public final class WalletViewModel: SheklyViewModel {
    // MARK: - Internal properties
    var selectedMonthDate: Date?
    var selectedWallet: SheklyWalletModel?
    
    // MARK: - Private properties
    private var wallets: [SheklyWalletModel] = []
    private var entries: [SheklyWalletEntryModel] = []
    
    private let dataController: SheklyDataController
    private weak var presenter: WalletPresenter?
    private let currencyFormatter: SheklyCurrencyFormatter
    private let differ: Differ
    private let userProvider: UserManaging
    
    // MARK: - Constructor
    init(
        presenter: WalletPresenter,
        dataController: SheklyDataController,
        differ: Differ,
        currencyFormatter: SheklyCurrencyFormatter,
        userProvider: UserManaging
        ) {
        
        self.presenter = presenter
        self.dataController = dataController
        self.differ = differ
        self.currencyFormatter = currencyFormatter
        self.userProvider = userProvider
        
        self.selectedMonthDate = Date()
        
        let wallets = dataController.getWallets().map(SheklyWalletModel.init)
        let selectedWallet = wallets.filter { $0.id == userProvider.selectedWalletId }.first
        self.selectedWallet = selectedWallet ?? wallets.first
        
        super.init()
    }
    
    // MARK: - Public methods
    public override func viewDidAppear() {
        reloadEntries()
        reloadWallets()
    }
}

// MARK: - Public methods
public extension WalletViewModel {
    func monthCollectionViewDidScroll(toDate date: Date) {
        selectedMonthDate = date
        reloadEntries()
    }
    
    func numberOfWalletItems() -> Int {
        return wallets.count
    }
    
    func walletCollectionView(modelForItemAt indexPath: IndexPath) -> SheklyWalletModel {
        return wallets[indexPath.row]
    }
    
    func walletCollectionViewDidScroll(toItemAt indexPath: IndexPath) {
        let wallet = wallets[indexPath.row]
        
        guard wallet.isEmpty == false else {
            return
        }
        
        selectedWallet = wallet
        userProvider.set(wallet: wallet.id)
        reloadEntries()
    }
    
    func numberOfEntries() -> Int {
        let count = entries.count
        guard count > 0 else {
            return 1
        }
        
        return count
    }
    
    func entryModel(forIndexPath indexPath: IndexPath) -> SheklyEntryModel {
        let model: SheklyEntryModel? = entries[safe: indexPath.row]
        
        return model ?? SheklyEntryEmptyModel()
    }
    
    func deleteEntry(atIndexPath indexPath: IndexPath) -> Bool {
        let entries: [WalletEntryModel] = self.entries.map { $0.entry }
        let entry: WalletEntryModel = entries[indexPath.row]
        
        let success = dataController.delete(entry: entry)
        
        reloadEntries()
        
        return success
    }
    
    func addWallet(named name: String) {
        let wallet: WalletModel = WalletModel(name: name, properties: nil)
        let savedWallet: WalletModel = dataController.save(wallet: wallet)
        
        selectedWallet = SheklyWalletModel(wallet: savedWallet)
        reloadWallets()
        reloadEntries()
    }
}

// MARK: - Internal methods
extension WalletViewModel {
    func reloadWallets() {
        let wallets: [SheklyWalletModel] = dataController.getWallets().map(SheklyWalletModel.init)
        let emptyModel = SheklyWalletModel(wallet: nil)
        
        self.wallets = wallets + [emptyModel]
        
        presenter?.reloadWallets()
    }
    
    func reloadEntries() {
        guard let wallet = selectedWallet?.wallet, let date = selectedMonthDate else {
            return
        }
        
        let entries: [WalletEntryModel] = dataController.getWalletEntries(forWallet: wallet, date: date)
        let entryModels: [SheklyWalletEntryModel] = entries
            .sorted()
            .map { entry -> SheklyWalletEntryModel in
                return SheklyWalletEntryModel(entry: entry, formatter: currencyFormatter)
        }
        
        let models: [SheklyEntryModel]
            
        if entries.isEmpty == true {
            models = [SheklyEntryEmptyModel()]
        } else {
            models = entryModels
        }
        
        let oldState: [SheklyEntryModel]
        
        if self.entries.isEmpty == true {
            oldState = [SheklyEntryEmptyModel()]
        } else {
            oldState = self.entries
        }
        
        self.entries = entryModels
        
        let changeSet: ChangeSet = differ.getDiff(oldState: oldState, newState: models)
        
        presenter?.reload(changeSet: changeSet)
    }
}

private extension Array where Element == WalletEntryModel {
    func sorted() -> [Element] {
        return self
            .sorted { (left, right) -> Bool in
                guard let leftDate = left.date,
                    let rightDate = right.date else {
                        return false
                }
                
                return leftDate > rightDate
            }
    }
}
