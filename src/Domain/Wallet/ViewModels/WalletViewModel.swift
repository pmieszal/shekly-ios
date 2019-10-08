//
//  WalletViewModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 05/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import RxSwift

import User
import SHTokenField
import Database
import Shared

public protocol WalletPresenter: ReloadablePresenter {
    func reloadWallets()
}

public final class WalletViewModel: SheklyViewModel {
    
    //MARK: - Internal properties
    var selectedMonthDate: Date?
    var selectedWallet: SheklyWalletModel?
    
    //MARK: - Private properties
    private var wallets: [SheklyWalletModel] = []
    private var entries: [SheklyWalletEntryModel] = []
    
    private let dataController: SheklyDataController
    private weak var presenter: WalletPresenter?
    private let currencyFormatter: SheklyCurrencyFormatter
    private let differ: Differ
    private let userProvider: UserManaging
    
    //MARK: - Constructor
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
    
    //MARK: - Public methods
    public override func viewDidAppear() {
        self.reloadEntries()
        self.reloadWallets()
    }
    
    public func monthCollectionViewDidScroll(toDate date: Date) {
        self.selectedMonthDate = date
        self.reloadEntries()
    }
    
    public func numberOfWalletItems() -> Int {
        return self.wallets.count
    }
    
    public func walletCollectionView(modelForItemAt indexPath: IndexPath) -> SheklyWalletModel {
        return self.wallets[indexPath.row]
    }
    
    public func walletCollectionViewDidScroll(toItemAt indexPath: IndexPath) {
        let wallet = self.wallets[indexPath.row]
        
        guard wallet.isEmpty == false else { return }
        
        self.selectedWallet = wallet
        self.userProvider.set(wallet: wallet.id)
        self.reloadEntries()
    }
    
    public func numberOfEntries() -> Int {
        let count = self.entries.count
        guard count > 0 else { return 1 }
        
        return count
    }
    
    public func entryModel(forIndexPath indexPath: IndexPath) -> SheklyEntryModel {
        let model: SheklyEntryModel? = self.entries[safe: indexPath.row]
        
        return model ?? SheklyEntryEmptyModel()
    }
    
    public func deleteEntry(atIndexPath indexPath: IndexPath) -> Bool {
        let entries: [WalletEntryModel] = self.entries.map { $0.entry }
        let entry: WalletEntryModel = entries[indexPath.row]
        
        let success = dataController.delete(entry: entry)
        
        self.reloadEntries()
        
        return success
    }
    
    public func addWallet(named name: String) {
        let wallet: WalletModel = WalletModel(name: name, properties: nil)
        let savedWallet: WalletModel = self.dataController.save(wallet: wallet)
        
        self.selectedWallet = SheklyWalletModel(wallet: savedWallet)
        self.reloadWallets()
        self.reloadEntries()
    }
}

//MARK: - Internal methods
extension WalletViewModel {
    
    func reloadWallets() {
        let wallets: [SheklyWalletModel] = self.dataController.getWallets().map(SheklyWalletModel.init)
        let emptyModel = SheklyWalletModel(wallet: nil)
        
        self.wallets = wallets + [emptyModel]
        
        self.presenter?.reloadWallets()
    }
    
    func reloadEntries() {
        guard let wallet = self.selectedWallet?.wallet, let date = self.selectedMonthDate else { return }
        
        let entries: [WalletEntryModel] = self.dataController.getWalletEntries(forWallet: wallet, date: date)
        let entryModels: [SheklyWalletEntryModel] = entries
            .sorted()
            .map { entry -> SheklyWalletEntryModel in
                return SheklyWalletEntryModel(entry: entry, formatter: currencyFormatter)
        }
        
        let models: [SheklyEntryModel]
            
        if entries.isEmpty == true {
            models = [SheklyEntryEmptyModel()]
        }
        else {
            models = entryModels
        }
        
        let oldState: [SheklyEntryModel]
        
        if self.entries.isEmpty == true {
            oldState = [SheklyEntryEmptyModel()]
        }
        else {
            oldState = self.entries
        }
        
        self.entries = entryModels
        
        let changeSet: ChangeSet = self.differ.getDiff(oldState: oldState, newState: models)
        
        self.presenter?.reload(changeSet: changeSet)
    }
}

private extension Array where Element == WalletEntryModel {
    
    func sorted() -> Array<Element> {
        return self
            .sorted { (left, right) -> Bool in
                guard let leftDate = left.date, let rightDate = right.date else { return false }
                
                return leftDate > rightDate
            }
    }
}
