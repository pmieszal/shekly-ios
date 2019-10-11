//
//  SheklyWalletEntryEmptyCell.swift
//  UI
//
//  Created by Patryk Mieszała on 04/04/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit

class SheklyWalletEntryEmptyCell: UITableViewCell {
    @IBOutlet private weak var ibContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ibContainerView.roundCorners(corners: .allCorners, radius: 6)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        ibContainerView.roundCorners(corners: .allCorners, radius: 6)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        ibContainerView.roundCorners(corners: .allCorners, radius: 6)
    }
}
