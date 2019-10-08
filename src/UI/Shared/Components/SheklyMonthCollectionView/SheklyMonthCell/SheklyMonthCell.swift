//
//  SheklyMonthCell.swift
//  UI
//
//  Created by Patryk Mieszała on 19/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import SwiftDate

import Shared

private struct CellConsts {
    static let font: UIFont = UIFont.systemFont(ofSize: 20, weight: .regular)
    static let defaultColor: UIColor = .white
    static let inactiveColor: UIColor = Colors.text1Color
}

class SheklyMonthCell: UICollectionViewCell {
    
    @IBOutlet private weak var ibMonthLabel: UILabel!
    
    var date: Date = Date() {
        didSet {
            let style = SheklyMonthCell.style(forDate: date)
            
            ibMonthLabel.text = date.toString(style)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ibMonthLabel.text = nil
    }
    
    func updateLayout(forCenter center: CGPoint, parentSize: CGSize) {
        let centerX: CGFloat = center.x
        let parentCenterX: CGFloat = parentSize.width / 2
        let diffX: CGFloat = abs(centerX - parentCenterX)
        
        let width: CGFloat = self.frame.width / 2
        let scale: CGFloat = width/diffX
        let scaleNormalized: CGFloat = max(min(scale, 1), 0.7)
        
        ibMonthLabel.transform = CGAffineTransform(scaleX: scaleNormalized, y: scaleNormalized)
        
        let colorWeight: CGFloat = scaleNormalized == 1 ? 1 : max((0.3 - (1 - scaleNormalized)) / 0.3, 0)
        
        let color = CellConsts
            .inactiveColor
            .mixed(withColor: CellConsts.defaultColor,
                   weight: colorWeight,
                   inColorSpace: .rgb)
        
        ibMonthLabel.textColor = color
    }
    
    class func size(forDate date: Date, inCollectionView collectionView: UICollectionView) -> CGSize {
        
        let style = SheklyMonthCell.style(forDate: date)
        let string = date.toString(style)
        let nsString = NSString(string: string)
        
        let atts: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: CellConsts.font
        ]
        let size = nsString.size(withAttributes: atts)
        
        let width: CGFloat = size.width + 8
        
        return CGSize(width: width, height: collectionView.frame.height)
    }
    
    class func style(forDate date: Date) -> DateToStringStyles {
        if date.year == Date().year {
            return DateToStringStyles.custom("MMMM")
        }
        
        return DateToStringStyles.custom("MMMM yyyy")
        
    }
}
