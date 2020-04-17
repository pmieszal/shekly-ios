//
//  WalletEntriesDataSource.swift
//  Wallet
//
//  Created by Patryk Mieszała on 16/04/2020.
//

import UIKit
import Domain

class WalletEntriesDataSource: UITableViewDiffableDataSource<String, SheklyWalletEntryModel> {
    override init(tableView: UITableView,
                  cellProvider: @escaping WalletEntriesDataSource.CellProvider) {
        super.init(tableView: tableView, cellProvider: cellProvider)
        defaultRowAnimation = .fade
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
