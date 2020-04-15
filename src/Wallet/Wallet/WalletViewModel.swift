//
//  WalletViewModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 05/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import User
import Common
import CleanArchitectureHelpers
import Domain

public final class WalletViewModel: ViewModel {
    // MARK: - Internal properties
    var selectedMonthDate: Date?
    var selectedWallet: SheklyWalletModel?
    
    // MARK: - Private properties
    private var wallets: [SheklyWalletModel] = []
    private var entries: [SheklyWalletEntryModel] = []
    
    private let walletRepository: WalletRepository
    private let walletEntriesRepository: WalletEntriesRepository
    
    private weak var presenter: WalletPresenter?
    private let currencyFormatter: SheklyCurrencyFormatter
    private let differ: Differ
    private let userProvider: UserManaging
    
    // MARK: - Constructor
    init(presenter: WalletPresenter,
         walletRepository: WalletRepository,
         walletEntriesRepository: WalletEntriesRepository,
         differ: Differ,
         currencyFormatter: SheklyCurrencyFormatter,
         userProvider: UserManaging) {
        self.presenter = presenter
        self.walletRepository = walletRepository
        self.walletEntriesRepository = walletEntriesRepository
        self.differ = differ
        self.currencyFormatter = currencyFormatter
        self.userProvider = userProvider
        
        self.selectedMonthDate = Date()
        
        //TODO: this
        let wallets = walletRepository.getWallets()
        let selectedWallet = wallets.filter { $0.id == userProvider.selectedWalletId }.first
        self.selectedWallet = selectedWallet ?? wallets.first
    }
    
    // MARK: - Public methods
    public func viewWillAppear() {
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
        return entries.count
    }
    
    func entryModel(forIndexPath indexPath: IndexPath) -> SheklyWalletEntryModel {
        let model: SheklyWalletEntryModel? = entries[safe: indexPath.row]
        
        return model ?? SheklyEntryEmptyModel()
    }
    
    func deleteEntry(atIndexPath indexPath: IndexPath) -> Bool {
        guard let entry = entries[safe: indexPath.row] else {
            return false
        }
        
        let success = walletEntriesRepository.delete(entry: entry)
        reloadEntries()
        
        return success
    }
    
    func addWallet(named name: String) {
        let wallet = SheklyWalletModel(name: name, id: nil)
        let savedWallet = walletRepository.save(wallet: wallet)
        
        selectedWallet = savedWallet
        reloadWallets()
        reloadEntries()
    }
}

// MARK: - Internal methods
extension WalletViewModel {
    func reloadWallets() {
        let wallets: [SheklyWalletModel] = walletRepository.getWallets()
        //TODO: emptymodel should be logic in UI
        let emptyModel = SheklyWalletModel(name: nil, id: nil)

        self.wallets = wallets + [emptyModel]
        
        presenter?.reloadWallets()
    }
    
    func reloadEntries() {
        //TODO: this
        guard let selectedWallet = selectedWallet, let date = selectedMonthDate else {
            return
        }

        let entries = walletEntriesRepository.getWalletEntries(forWallet: selectedWallet, date: date)
        let entryModels: [SheklyWalletEntryModel] = entries
            .sorted()

        let models: [SheklyWalletEntryModel] = entries.isEmpty ? [SheklyEntryEmptyModel()] : entryModels
        let oldState = self.entries

        let changeSet: ChangeSet = differ.getDiff(oldState: oldState, newState: models)

        presenter?.reload(changeSet: changeSet, setData: { [weak self] in
            self?.entries = models
        })
    }
}
