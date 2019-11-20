//
//  SheklyDataController.swift
//  Database
//
//  Created by Patryk Mieszała on 20/11/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

public protocol SheklyDataController: AnyObject {
    func getWallets() -> [WalletModel]
    func getCategories(forWallet wallet: WalletModel) -> [CategoryModel]
    func getSubcategories(forCategory category: CategoryModel) -> [SubcategoryModel]
    func getWalletEntries(forWallet wallet: WalletModel) -> [WalletEntryModel]
    func getWalletEntries(forWallet wallet: WalletModel, date: Date) -> [WalletEntryModel]
    func getWalletEntries(forCategory category: CategoryModel) -> [WalletEntryModel]
    func save(wallet: WalletModel) -> WalletModel
    func save(entry: WalletEntryModel)
    func delete(entry: WalletEntryModel) -> Bool
}
