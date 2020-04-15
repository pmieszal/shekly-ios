//
//  WalletEntryCell.swift
//  UI
//
//  Created by Patryk Mieszała on 13/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Domain

class WalletEntryCell: UITableViewCell {
    @IBOutlet private weak var entryView: UIView!
    @IBOutlet private weak var subcategoryLabel: UILabel!
    @IBOutlet private weak var categoryAndCommentLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        entryView.roundCorners(corners: [.topRight, .bottomRight], radius: 6)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        entryView.roundCorners(corners: [.topRight, .bottomRight], radius: 6)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        entryView.roundCorners(corners: [.topRight, .bottomRight], radius: 6)
    }
    
    func setup(with model: SheklyWalletEntryModel) {
        entryView.roundCorners(corners: [.topRight, .bottomRight], radius: 6)
        
        categoryAndCommentLabel.text = model.categoryAndComment
        subcategoryLabel.text = model.subcategory
        amountLabel.text = model.amount
        amountLabel.textColor = model.entryType?.textColor
        dateLabel.text = model.dateString
    }
}
