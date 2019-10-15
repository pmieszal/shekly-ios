//
//  SheklyWalletCell.swift
//  UI
//
//  Created by Patryk Mieszała on 21/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Domain

class SheklyWalletCell: UICollectionViewCell {
    
    @IBOutlet private weak var contentStackView: UIStackView!
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var toSpendAmountLabel: UILabel!
    
    @IBOutlet private weak var planIncomeLabel: UILabel!
    @IBOutlet private weak var planOutcomeLabel: UILabel!
    
    @IBOutlet private weak var realIncomeLabel: UILabel!
    @IBOutlet private weak var realOutcomeLabel: UILabel!

    @IBOutlet private weak var emptyView: UIView!
    @IBOutlet private weak var addButton: UIButton!
    
    var model: SheklyWalletModel! {
        didSet {
            initialize()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layoutAddButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutAddButton()
    }
    
    override func layoutIfNeeded() {
        super.layoutSubviews()
        
        layoutAddButton()
    }
    
    func setAddButton(target: Any?, action: Selector, for event: UIControl.Event) {
        addButton.addTarget(target, action: action, for: event)
    }
}

private extension SheklyWalletCell {
    
    func layoutAddButton() {
        addButton.layer.cornerRadius = addButton.frame.height / 2
        addButton.layer.borderColor = UIColor.white.cgColor
        addButton.layer.borderWidth = 1
    }
    
    func initialize() {
        emptyView.isHidden = model.isEmpty == false
        contentStackView.isHidden = model.isEmpty == true
        
        nameLabel.text = model.name
    }
}
