//
//  WalletListCell.swift
//  UI
//
//  Created by Patryk Mieszała on 07/04/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Common

public class WalletListCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.textColor = Colors.brandColor
    }
}
