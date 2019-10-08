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

    @IBOutlet private weak var ibEntryView: UIView!
    @IBOutlet private weak var ibSubcategoryLabel: UILabel!
    @IBOutlet private weak var ibCategoryAndCommentLabel: UILabel!
    @IBOutlet private weak var ibDateLabel: UILabel!
    @IBOutlet private weak var ibAmountLabel: UILabel!
    
    var model: SheklyEntryModel! {
        didSet {
            self.initialize()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ibEntryView.roundCorners(corners: [.topRight, .bottomRight], radius: 6)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        ibEntryView.roundCorners(corners: [.topRight, .bottomRight], radius: 6)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        ibEntryView.roundCorners(corners: [.topRight, .bottomRight], radius: 6)
    }
    
    private func initialize() {
        ibEntryView.roundCorners(corners: [.topRight, .bottomRight], radius: 6)
        
        ibCategoryAndCommentLabel.text = model.categoryAndComment
        ibSubcategoryLabel.text = model.subcategory
        ibAmountLabel.text = model.amount
        ibAmountLabel.textColor = model.amountColor
        ibDateLabel.text = model.dateString
    }
}
