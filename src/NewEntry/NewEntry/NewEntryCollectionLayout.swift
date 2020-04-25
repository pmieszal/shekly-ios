//
//  NewEntryCollectionLayout.swift
//  NewEntry
//
//  Created by Patryk Mieszała on 25/04/2020.
//

import UIKit

class NewEntryCollectionLayout: UICollectionViewCompositionalLayout {
    class func layout() -> NewEntryCollectionLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(100),
          heightDimension: .estimated(27))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(32))
        let group = NSCollectionLayoutGroup.horizontal(
          layoutSize: groupSize,
          subitems: [item])
        group.interItemSpacing = .fixed(4)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 4,
            bottom: 2,
            trailing: 4)
        
        let layout = NewEntryCollectionLayout(section: section)
        
        return layout
    }
}
