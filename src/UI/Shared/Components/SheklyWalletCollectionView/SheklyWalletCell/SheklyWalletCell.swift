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
    
    @IBOutlet private weak var ibContentStackView: UIStackView!
    
    @IBOutlet private weak var ibNameLabel: UILabel!
    @IBOutlet private weak var ibToSpendAmountLabel: UILabel!
    
    @IBOutlet private weak var ibPlanIncomeLabel: UILabel!
    @IBOutlet private weak var ibPlanOutcomeLabel: UILabel!
    
    @IBOutlet private weak var ibRealIncomeLabel: UILabel!
    @IBOutlet private weak var ibRealOutcomeLabel: UILabel!

    @IBOutlet private weak var ibEmptyView: UIView!
    @IBOutlet private weak var ibAddButton: UIButton!
    
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
        ibAddButton.addTarget(target, action: action, for: event)
    }
}

private extension SheklyWalletCell {
    
    func layoutAddButton() {
        ibAddButton.layer.cornerRadius = ibAddButton.frame.height / 2
        ibAddButton.layer.borderColor = UIColor.white.cgColor
        ibAddButton.layer.borderWidth = 1
    }
    
    func initialize() {
        ibEmptyView.isHidden = model.isEmpty == false
        ibContentStackView.isHidden = model.isEmpty == true
        
        ibNameLabel.text = model.name
    }
}
