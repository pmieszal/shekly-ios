import Common
import CommonUI
import Domain
import UIKit

import CleanArchitectureHelpers

protocol WalletViewControllerLogic: ViewControllerLogic {
    func display(walletName: String?)
    func reloadEntries(snapshot: NSDiffableDataSourceSnapshot<String, WalletEntryCellModel>)
    func reloadWallets(snapshot: NSDiffableDataSourceSnapshot<String, WalletModel>)
}

final class WalletViewController: SheklyViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var headerView: WalletHeaderView!
    
    lazy var navigationTitleView = R.nib.walletNavigationTitleView.firstView(owner: nil)
    
    // MARK: - Public Properties
    var interactor: WalletInteractorLogic?
    var router: WalletRouterType?
    
    lazy var dataSource = WalletEntriesDataSource(tableView: tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.viewWillAppear?()
    }
}

extension WalletViewController: WalletViewControllerLogic {
    func display(walletName: String?) {
        navigationTitleView?.set(title: walletName)
    }
    
    func reloadEntries(snapshot: NSDiffableDataSourceSnapshot<String, WalletEntryCellModel>) {
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func reloadWallets(snapshot: NSDiffableDataSourceSnapshot<String, WalletModel>) {
        //headerView.reload(snapshot: snapshot)
    }
}

extension WalletViewController: WalletMonthCollectionViewDelegate {
    func monthCollectionViewDidScroll(toDate date: Date) {
        interactor?.monthCollectionViewDidScroll(toDate: date)
    }
}

extension WalletViewController: WalletCollectionViewDelegate {
    func walletCollectionViewDidScroll(toItemAt indexPath: IndexPath) {
        interactor?.walletCollectionViewDidScroll(toItemAt: indexPath)
    }
    
    func walletCollectionDidTapAdd() {
        let alert = UIAlertController(title: CommonUI.R.string.localizable.new_wallet_alert_title(), message: nil, preferredStyle: .alert)
        
        alert.addTextField()
        
        let addAction = UIAlertAction(
            title: CommonUI.R.string.localizable.new_wallet_alert_create_action(),
            style: .default,
            handler: { [weak self] _ in
                guard let name = alert.textFields?.first?.text else {
                    return
                }
                
                self?.interactor?.addWallet(named: name)
        })
        
        let cancelAction = UIAlertAction(title: CommonUI.R.string.localizable.common_error_delete_cancel_action(), style: .cancel, handler: nil)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

extension WalletViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: nil,
            handler: { [unowned self] _, _, completion in
                let alertInput = AlertControllerInput(
                    title: CommonUI.R.string.localizable.wallet_entry_delete_title(),
                    message: nil,
                    style: .actionSheet)
                let actions: [UIAlertAction] = .defaultDeleteActions(
                    okHandler: { [unowned self] _ in
                        self.interactor?.deleteEntry(atIndexPath: indexPath, completion: completion)
                    },
                    cancelHandler: { _ in
                        completion(false)
                })
                
                self.showAlert(input: alertInput, actions: actions)
        })
        
        deleteAction.image = CommonUI.R.image.trashIcon()
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

private extension WalletViewController {
    func setup() {
        navigationItem.titleView = navigationTitleView
        
        headerView.monthCollectionDelegate = self
        headerView.layer.shadowColor = Colors.brandColor.cgColor
        headerView.layer.shadowOpacity = 0.5
        headerView.layer.shadowRadius = 2
        headerView.layer.shadowOffset.height = 2
        
        tableView.delegate = self
        tableView.register(R.nib.walletEntryCell)
        tableView.register(R.nib.walletEntryEmptyCell)
        
        tableView.tableFooterView = UIView()
        tableView.contentInset.top = 4
        tableView.contentInset.bottom = 4
        tableView.contentOffset.y = -4
    }
}
