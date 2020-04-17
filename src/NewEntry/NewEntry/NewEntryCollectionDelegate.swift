//
//  NewEntryCollectionDelegate.swift
//  NewEntry
//
//  Created by Patryk Mieszała on 17/04/2020.
//

import UIKit

class NewEntryCollectionDelegate: NSObject, UICollectionViewDelegate {
    private enum Constants {
        static let cellWidthOffset: CGFloat = 30
        static let cellHeight: CGFloat = 27
    }
    
    let dataSource: NewEntryCollectionDataSource
    
    var didSelectItem: ((String) -> Void)?
    
    init(dataSource: NewEntryCollectionDataSource) {
        self.dataSource = dataSource
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        didSelectItem?(item)
    }
}

extension NewEntryCollectionDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = dataSource.itemIdentifier(for: indexPath)
        
        let atts = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .light)]
        
        guard let stringSize = title?.size(withAttributes: atts) else {
            return .zero
        }
        
        let cellSize = CGSize(width: stringSize.width + Constants.cellWidthOffset, height: Constants.cellHeight)
        
        return cellSize
    }
}
