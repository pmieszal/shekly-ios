import CleanArchitectureHelpers
import Common

public protocol ReloadableViewController: ReloadablePresenter {
    var reloadableView: ReloadableView? { get }
}

public protocol ReloadableView: AnyObject {
    func performBatchUpdates(_ updates: (() -> Void)?, completion: ((Bool) -> Void)?)
    func deleteRows(at indexPaths: [IndexPath], with: UITableView.RowAnimation)
    func insertRows(at indexPaths: [IndexPath], with: UITableView.RowAnimation)
    func reloadRows(at indexPaths: [IndexPath], with: UITableView.RowAnimation)
    func moveRow(at indexPath: IndexPath, to newIndexPath: IndexPath)
}

extension UITableView: ReloadableView {}
extension UICollectionView: ReloadableView {
    public func deleteRows(at indexPaths: [IndexPath], with: UITableView.RowAnimation) {
        deleteItems(at: indexPaths)
    }
    
    public func insertRows(at indexPaths: [IndexPath], with: UITableView.RowAnimation) {
        insertItems(at: indexPaths)
    }
    
    public func reloadRows(at indexPaths: [IndexPath], with: UITableView.RowAnimation) {
        reloadItems(at: indexPaths)
    }
    
    public func moveRow(at indexPath: IndexPath, to newIndexPath: IndexPath) {
        moveItem(at: indexPath, to: newIndexPath)
    }
}

public extension ReloadableViewController {
    func reload(changeSet: ChangeSet, setData: (() -> Void)?) {
        reloadableView?.performBatchUpdates({ [weak self] in
            setData?()
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
