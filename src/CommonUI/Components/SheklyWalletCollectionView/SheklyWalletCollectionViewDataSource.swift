import Domain
import UIKit

class SheklyWalletCollectionViewDataSource: UICollectionViewDiffableDataSource<String, WalletModel> {
    override init(collectionView: UICollectionView,
                  cellProvider: @escaping SheklyWalletCollectionViewDataSource.CellProvider) {
        super.init(collectionView: collectionView, cellProvider: cellProvider)
    }
}
