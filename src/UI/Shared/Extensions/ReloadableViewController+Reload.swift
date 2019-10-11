//
//  ReloadableViewController+Reload.swift
//  UI
//
//  Created by Patryk Mieszała on 04/04/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Domain

protocol ReloadableViewController: ReloadablePresenter {
    var reloadableView: ReloadableView? { get }
}

protocol ReloadableView: AnyObject {
    func performBatchUpdates(_ updates: (() -> Void)?, completion: ((Bool) -> Void)?)
    func deleteRows(at indexPaths: [IndexPath], with: UITableView.RowAnimation)
    func insertRows(at indexPaths: [IndexPath], with: UITableView.RowAnimation)
    func reloadRows(at indexPaths: [IndexPath], with: UITableView.RowAnimation)
    func moveRow(at indexPath: IndexPath, to newIndexPath: IndexPath)
}

extension UITableView: ReloadableView {}
extension UICollectionView: ReloadableView {
    func deleteRows(at indexPaths: [IndexPath], with: UITableView.RowAnimation) {
        deleteItems(at: indexPaths)
    }
    
    func insertRows(at indexPaths: [IndexPath], with: UITableView.RowAnimation) {
        insertItems(at: indexPaths)
    }
    
    func reloadRows(at indexPaths: [IndexPath], with: UITableView.RowAnimation) {
        reloadItems(at: indexPaths)
    }
    
    func moveRow(at indexPath: IndexPath, to newIndexPath: IndexPath) {
        moveItem(at: indexPath, to: newIndexPath)
    }
}

extension ReloadableViewController {
    func reload(changeSet: ChangeSet) {
        reloadableView?.performBatchUpdates({ [weak self] in
            self?.reloadableView?.deleteRows(at: changeSet.deleted, with: .fade)
            self?.reloadableView?.insertRows(at: changeSet.inserted, with: .fade)
            self?.reloadableView?.reloadRows(at: changeSet.updated, with: .none)
            
            for moved in changeSet.moved {
                self?.reloadableView?.moveRow(at: moved.from, to: moved.to)
            }
        }, completion: nil)
    }
    
    func reload(changeSet: ChangeSet, reloadableView: ReloadableView) {
        reloadableView.performBatchUpdates({
            
            reloadableView.deleteRows(at: changeSet.deleted, with: .fade)
            reloadableView.insertRows(at: changeSet.inserted, with: .fade)
            reloadableView.reloadRows(at: changeSet.updated, with: .none)
            
            for moved in changeSet.moved {
                reloadableView.moveRow(at: moved.from, to: moved.to)
            }
        }, completion: nil)
    }
}
