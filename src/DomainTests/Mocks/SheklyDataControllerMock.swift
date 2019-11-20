//
//  SheklyDataControllerMock.swift
//  DomainTests
//
//  Created by Patryk Mieszała on 20/11/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Database

class SheklyDataControllerMock: SheklyDataController {
    
    var wallets: [WalletModel] = []
    var categoriesForWallet: ((WalletModel) -> [CategoryModel])?
    
    func getWallets() -> [WalletModel] {
        return wallets
    }
    
    func getCategories(forWallet wallet: WalletModel) -> [CategoryModel] {
        return categoriesForWallet?(wallet) ?? []
    }
    
    func getSubcategories(forCategory category: CategoryModel) -> [SubcategoryModel] {
        return []
    }
    
    func getWalletEntries(forWallet wallet: WalletModel) -> [WalletEntryModel] {
        return []
    }
    
    func getWalletEntries(forWallet wallet: WalletModel, date: Date) -> [WalletEntryModel] {
        return []
    }
    
    func getWalletEntries(forCategory category: CategoryModel) -> [WalletEntryModel] {
        return []
    }
    
    func save(wallet: WalletModel) -> WalletModel {
        return wallet
    }
    
    func save(entry: WalletEntryModel) { }
    
    func delete(entry: WalletEntryModel) -> Bool {
        return true
    }
}
