//
//  WalletInteractor.swift
//  Shekly-generated
//
//  Created by Patryk Mieszała on 16/04/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import User
import Common
import CleanArchitectureHelpers
import Domain

protocol WalletInteractorLogic: InteractorLogic {
    func monthCollectionViewDidScroll(toDate date: Date)
    func walletCollectionViewDidScroll(toItemAt indexPath: IndexPath)
    func addWallet(named name: String)
    func deleteEntry(atIndexPath indexPath: IndexPath) -> Bool
}

protocol WalletDataStore {}

final class WalletInteractor: WalletDataStore {
    // MARK: - Internal properties
    var selectedMonthDate: Date?
    var selectedWallet: WalletModel?
    
    // MARK: - Private properties
    private var wallets: [WalletModel] = []
    private var entries: [WalletEntryModel] = []
    
    private let walletRepository: WalletRepository
    private let walletEntriesRepository: WalletEntriesRepository
    
    private var presenter: WalletPresenterLogic
    private let currencyFormatter: SheklyCurrencyFormatter
    private let differ: Differ
    private let userProvider: UserManaging
    
    // MARK: - Initializers
    init(presenter: WalletPresenterLogic,
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
}

extension WalletInteractor: WalletInteractorLogic {
    func viewWillAppear() {
        reloadEntries()
        reloadWallets()
    }
}

extension WalletInteractor {
    func monthCollectionViewDidScroll(toDate date: Date) {
        selectedMonthDate = date
        reloadEntries()
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
    
    func deleteEntry(atIndexPath indexPath: IndexPath) -> Bool {
        guard let entry = entries[safe: indexPath.row] else {
            return false
        }
        
        let success = walletEntriesRepository.delete(entry: entry)
        reloadEntries()
        
        return success
    }
    
    func addWallet(named name: String) {
        let wallet = WalletModel(id: nil, name: name, entries: [])
        let savedWallet = walletRepository.save(wallet: wallet)
        
        selectedWallet = savedWallet
        reloadWallets()
        reloadEntries()
    }
}

private extension WalletInteractor {
    func reloadWallets() {
        let wallets = walletRepository.getWallets()
        let emptyModel = WalletModel(id: nil, name: nil, entries: [])

        self.wallets = wallets + [emptyModel]
        
        presenter.reload(wallets: self.wallets)
    }
    
    func reloadEntries() {
        //TODO: this
        guard let selectedWallet = selectedWallet, let date = selectedMonthDate else {
            return
        }

        let entries = walletEntriesRepository.getWalletEntries(forWallet: selectedWallet, date: date)
        let entryModels = entries.sorted()

        let models = entries.isEmpty ? [WalletEntryModel()] : entryModels
        self.entries = models

        presenter.reload(entries: models)
    }
}
