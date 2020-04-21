//
//  WalletEntriesRepository.swift
//  Domain
//
//  Created by Patryk Mieszała on 19/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

public protocol WalletEntriesRepository: AnyObject {
    func getWalletEntries(forWalletId walletId: String) -> [WalletEntryModel]
    func getWalletEntries(forWalletId walletId: String, monthDate: Date) -> [WalletEntryModel]
    func save(entry: WalletEntryModel)
    func delete(entry: WalletEntryModel) -> Bool
}
