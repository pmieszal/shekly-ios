//
//  WalletListViewController.swift
//  UI
//
//  Created by Patryk Mieszała on 07/04/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Domain

public class WalletListViewController: SheklyViewController<WalletListViewModel> {
    @IBOutlet private weak var tableView: UITableView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset.top = 5
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension WalletListViewController: WalletListPresenter {
    public func reloadList() {
        tableView.reloadData()
    }
}

extension WalletListViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.walletListCell, for: indexPath)!
        cell.nameLabel.text = viewModel.title(forRowAt: indexPath)
        
        return cell
    }
}

extension WalletListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(itemAt: indexPath)
        dismiss(animated: true, completion: nil)
    }
}
