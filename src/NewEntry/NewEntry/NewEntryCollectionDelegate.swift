//
//  NewEntryCollectionDelegate.swift
//  NewEntry
//
//  Created by Patryk Mieszała on 17/04/2020.
//

import UIKit

private enum Constants {
    static let cellWidthOffset: CGFloat = 30
    static let cellHeight: CGFloat = 27
}

class NewEntryCollectionDelegate<TModel: NewEntryCellModel>: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let dataSource: NewEntryCollectionDataSource<TModel>
    
    var didSelectItem: ((String) -> Void)?
    
    init(dataSource: NewEntryCollectionDataSource<TModel>,
         didSelectItem: ((String) -> Void)?) {
        self.dataSource = dataSource
        self.didSelectItem = didSelectItem
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = dataSource.itemIdentifier(for: indexPath)?.id else {
            return
        }
        didSelectItem?(id)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = dataSource.itemIdentifier(for: indexPath)
        let atts = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .light)]
        
        guard let stringSize = item?.name.size(withAttributes: atts) else {
            return .zero
        }
        
        let cellSize = CGSize(width: stringSize.width + Constants.cellWidthOffset, height: Constants.cellHeight)
        
        return cellSize
    }
}
