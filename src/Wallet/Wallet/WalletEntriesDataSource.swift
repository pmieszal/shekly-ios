//
//  WalletEntriesDataSource.swift
//  Wallet
//
//  Created by Patryk Mieszała on 16/04/2020.
//

import UIKit
import Domain
import CommonUI

class WalletEntriesDataSource: UITableViewDiffableDataSource<String, WalletEntryCellModel> {
    init(tableView: UITableView) {
        super.init(tableView: tableView, cellProvider: { (tableView, indexPath, model) -> UITableViewCell in
                guard model.id?.isEmpty == false else {
                    guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: CommonUI.R.reuseIdentifier.sheklyWalletEntryEmptyCell,
                        for: indexPath) else {
                            assertionFailure("Cell can't be nil")
                            return UITableViewCell()
                    }
                    
                    return cell
                }
                
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: R.reuseIdentifier.walletEntryCell,
                    for: indexPath) else {
                        assertionFailure("Cell can't be nil")
                        return UITableViewCell()
                }
                cell.setup(with: model)
                
                return cell
        })
        defaultRowAnimation = .fade
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
