import Common
import CommonUI
import Domain
import UIKit

import CleanArchitectureHelpers

protocol WalletViewControllerLogic: ViewControllerLogic {
    func reloadEntries(snapshot: NSDiffableDataSourceSnapshot<String, WalletEntryCellModel>)
    func reloadWallets(snapshot: NSDiffableDataSourceSnapshot<String, WalletModel>)
}

final class WalletViewController: SheklyViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var headerView: WalletHeaderView!
    
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
    func reloadEntries(snapshot: NSDiffableDataSourceSnapshot<String, WalletEntryCellModel>) {
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func reloadWallets(snapshot: NSDiffableDataSourceSnapshot<String, WalletModel>) {
        headerView.reload(snapshot: snapshot)
    }
}

extension WalletViewController: SheklyMonthCollectionViewDelegate {
    func monthCollectionViewDidScroll(toDate date: Date) {
        interactor?.monthCollectionViewDidScroll(toDate: date)
    }
}

extension WalletViewController: WalletCollectionViewDelegate {
    func walletCollectionViewDidScroll(toItemAt indexPath: IndexPath) {
        interactor?.walletCollectionViewDidScroll(toItemAt: indexPath)
    }
    
    func walletCollectionDidTapAdd() {
        let alert = UIAlertController(title: "Dodaj nowy portfel", message: nil, preferredStyle: .alert)
        
        alert.addTextField()
        
        let addAction = UIAlertAction(
            title: "Dodaj",
            style: .default,
            handler: { [weak self] _ in
                guard let name = alert.textFields?.first?.text else {
                    return
                }
                
                self?.interactor?.addWallet(named: name)
        })
        
        let cancelAction = UIAlertAction(title: "Anuluj", style: .cancel, handler: nil)
        
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
                    title: "Czy na pewno chcesz usunąć wpis?",
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
        headerView.walletDelegate = self
        headerView.monthCollectionDelegate = self
        headerView.layer.shadowColor = Colors.brandColor.cgColor
        headerView.layer.shadowOpacity = 0.5
        headerView.layer.shadowRadius = 2
        headerView.layer.shadowOffset.height = 2
        
        tableView.delegate = self
        tableView.register(R.nib.walletEntryCell)
        tableView.register(CommonUI.R.nib.sheklyWalletEntryEmptyCell)
        
        tableView.tableFooterView = UIView()
        tableView.contentInset.top = 4
        tableView.contentInset.bottom = 4
        tableView.contentOffset.y = -4
    }
}
