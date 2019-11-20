//
//  WalletEntriesRepository.swift
//  Domain
//
//  Created by Patryk Mieszała on 19/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

public protocol WalletEntriesRepository: AnyObject {
    func getWalletEntries(forWallet wallet: SheklyWalletModel) -> [SheklyWalletEntryModel]
    func getWalletEntries(forWallet wallet: SheklyWalletModel, date: Date) -> [SheklyWalletEntryModel]
    func getWalletEntries(forCategory category: SheklyCategoryModel) -> [SheklyWalletEntryModel]
    func save(entry: SheklyWalletEntryModel) -> SheklyWalletEntryModel
    func delete(entry: SheklyWalletEntryModel) -> Bool
}
