//
//  NewEntryCollectionDataSource.swift
//  NewEntry
//
//  Created by Patryk Mieszała on 17/04/2020.
//

import UIKit
import Domain

class NewEntryCollectionDataSource: UICollectionViewDiffableDataSource<String, String> {
    init(collectionView: UICollectionView) {
        super.init(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, model in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.newEntryCollectionCell,
                                                              for: indexPath)!
                
                cell.text = model
                
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
