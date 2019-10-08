//
//  WalletListViewController.swift
//  UI
//
//  Created by Patryk Mieszała on 07/04/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Domain

class WalletListViewController: SheklyViewController<WalletListViewModel>, WalletListPresenter, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet private weak var ibTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ibTableView.contentInset.top = 5
        ibTableView.dataSource = self
        ibTableView.delegate = self
    }
    
    func reloadList() {
        ibTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.walletListCell, for: indexPath)!
        cell.ibNameLabel.text = viewModel.title(forRowAt: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(itemAt: indexPath)
        self.dismiss(animated: true, completion: nil)
    }
}
