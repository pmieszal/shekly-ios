//
//  WalletListCell.swift
//  UI
//
//  Created by Patryk Mieszała on 07/04/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Shared

class WalletListCell: UITableViewCell {
    
    @IBOutlet weak var ibNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ibNameLabel.textColor = Colors.brandColor
    }
}
