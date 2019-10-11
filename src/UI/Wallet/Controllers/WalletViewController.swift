//
//  WalletViewController.swift
//  UI
//
//  Created by Patryk Mieszała on 03/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Domain
import SHTokenField
import Shared

class WalletViewController: SheklyViewController<WalletViewModel> {
    
    @IBOutlet private weak var ibTableView: UITableView!
    @IBOutlet private weak var ibHeaderView: WalletHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

extension WalletViewController: ReloadableViewController {
    
    var reloadableView: ReloadableView? {
        return ibTableView
    }
}

extension WalletViewController: WalletPresenter {
    func reloadWallets() {
        ibHeaderView.reloadWalletCollectionView()
    }
}

extension WalletViewController: SheklyMonthCollectionViewDelegate {
    func monthCollectionViewDidScroll(toDate date: Date) {
        viewModel.monthCollectionViewDidScroll(toDate: date)
    }
}


extension WalletViewController: WalletCollectionViewDataSource {
    func numberOfWalletItems() -> Int {
        return viewModel.numberOfWalletItems()
    }
    
    func walletCollectionView(modelForItemAt indexPath: IndexPath) -> SheklyWalletModel {
        return viewModel.walletCollectionView(modelForItemAt: indexPath)
    }
}

extension WalletViewController: WalletCollectionViewDelegate {
    func walletCollectionViewDidScroll(toItemAt indexPath: IndexPath) {
        viewModel.walletCollectionViewDidScroll(toItemAt: indexPath)
    }
    
    func walletCollectionDidTapAdd() {
        let alert = UIAlertController(title: "Dodaj nowy portfel", message: nil, preferredStyle: .alert)
        
        alert.addTextField()
        
        let addAction = UIAlertAction(title: "Dodaj", style: .default) { [weak self] (_) in
            guard let name = alert.textFields?.first?.text else { return }
            
            self?.viewModel.addWallet(named: name)
        }
        
        let cancelAction = UIAlertAction(title: "Anuluj", style: .cancel, handler: nil)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

extension WalletViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfEntries()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model: SheklyEntryModel = viewModel.entryModel(forIndexPath: indexPath)
        
        switch model {
        case let model as SheklyWalletEntryModel:
            guard let cell: WalletEntryCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.walletEntryCell, for: indexPath) else {
                fatalError("Cell can't be nil")
            }
            cell.model = model
            
            return cell
            
        case is SheklyEntryEmptyModel:
            guard let cell: SheklyWalletEntryEmptyCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.sheklyWalletEntryEmptyCell, for: indexPath) else {
                fatalError("Cell can't be nil")
            }
            
            return cell
        default:
            assertionFailure("Not implemented")
            
            return UITableViewCell()
        }
    }
}

extension WalletViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [unowned self] (action, view, completion) in
            
            let alertInput = AlertControllerInput(title: "Czy na pewno chcesz usunąć wpis?", message: nil, style: .actionSheet)
            let actions: [UIAlertAction] = .defaultDeleteActions(okHandler: { [unowned self] (_) in
                let success = self.viewModel.deleteEntry(atIndexPath: indexPath)
                
                completion(success)
            }, cancelHandler: { _ in
                completion(false)
            })
            
            self.showAlert(input: alertInput, actions: actions)
        }
        
        deleteAction.image = R.image.trashIcon()
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

private extension WalletViewController {
    
    func setup() {
        ibHeaderView.walletDataSource = self
        ibHeaderView.walletDelegate = self
        ibHeaderView.monthCollectionDelegate = self
        ibHeaderView.layer.shadowColor = Colors.brandColor.cgColor
        ibHeaderView.layer.shadowOpacity = 0.5
        ibHeaderView.layer.shadowRadius = 2
        ibHeaderView.layer.shadowOffset.height = 2
        
        ibTableView.delegate = self
        ibTableView.dataSource = self
        ibTableView.register(R.nib.walletEntryCell)
        ibTableView.register(R.nib.sheklyWalletEntryEmptyCell)
        
        ibTableView.tableFooterView = UIView()
        ibTableView.contentInset.top = 4
        ibTableView.contentInset.bottom = 4
        ibTableView.contentOffset.y = -4
    }
}
