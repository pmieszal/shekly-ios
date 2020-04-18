//
//  WalletListViewController.swift
//  Shekly-generated
//
//  Created by Patryk Mieszała on 18/04/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Domain
import CleanArchitectureHelpers

protocol WalletListViewControllerLogic: ViewControllerLogic {
    func reloadList(snapshot: NSDiffableDataSourceSnapshot<String, String?>)
}

public final class WalletListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var dataSource: UITableViewDiffableDataSource<String, String?> = UITableViewDiffableDataSource(
        tableView: tableView,
        cellProvider: { (tableView, indexPath, model) -> UITableViewCell in
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.walletListCell, for: indexPath)!
        cell.nameLabel.text = model
        
        return cell
    })
    
    // MARK: - Public Properties
    var interactor: WalletListInteractorLogic?
    var router: WalletListRouterType?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.viewDidLoad?()
        tableView.contentInset.top = 5
        tableView.delegate = self
    }
}

extension WalletListViewController: WalletListViewControllerLogic {
    func reloadList(snapshot: NSDiffableDataSourceSnapshot<String, String?>) {
        dataSource.apply(snapshot)
    }
}

extension WalletListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.didSelect(itemAt: indexPath)
        dismiss(animated: true, completion: nil)
    }
}
