//
//  SheklyWalletEntryEmptyCell.swift
//  UI
//
//  Created by Patryk Mieszała on 04/04/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit

class SheklyWalletEntryEmptyCell: UITableViewCell {
    @IBOutlet private weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.roundCorners(corners: .allCorners, radius: 6)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.roundCorners(corners: .allCorners, radius: 6)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        containerView.roundCorners(corners: .allCorners, radius: 6)
    }
}
