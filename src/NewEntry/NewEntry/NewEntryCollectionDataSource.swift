import Domain
import UIKit

class NewEntryCollectionDataSource<TModel: NewEntryCellModel>: UICollectionViewDiffableDataSource<String, TModel> {
    init(collectionView: UICollectionView) {
        super.init(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, model in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: R.reuseIdentifier.newEntryCollectionCell,
                    for: indexPath)!
                
                cell.text = model.name
                
                return cell
        })
        
        setup(collectionView: collectionView)
    }
    
    func setup(collectionView: UICollectionView) {
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        collectionView.register(R.nib.newEntryCollectionCell)
    }
}
