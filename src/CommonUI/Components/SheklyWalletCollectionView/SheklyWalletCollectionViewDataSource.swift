//
//  SheklyWalletCollectionViewDataSource.swift
//  CommonUI
//
//  Created by Patryk Mieszała on 16/04/2020.
//

import UIKit
import Domain

class SheklyWalletCollectionViewDataSource: UICollectionViewDiffableDataSource<String, WalletModel> {
    override init(collectionView: UICollectionView,
                  cellProvider: @escaping SheklyWalletCollectionViewDataSource.CellProvider) {
        super.init(collectionView: collectionView, cellProvider: cellProvider)
    }
}
