//
//  SheklyWalletCell.swift
//  UI
//
//  Created by Patryk Mieszała on 21/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Domain

public class SheklyWalletCell: UICollectionViewCell {
    
    @IBOutlet private weak var contentStackView: UIStackView!
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var toSpendAmountLabel: UILabel!
    
    @IBOutlet private weak var planIncomeLabel: UILabel!
    @IBOutlet private weak var planOutcomeLabel: UILabel!
    
    @IBOutlet private weak var realIncomeLabel: UILabel!
    @IBOutlet private weak var realOutcomeLabel: UILabel!

    @IBOutlet private weak var emptyView: UIView!
    @IBOutlet private weak var addButton: UIButton!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        layoutAddButton()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        layoutAddButton()
    }
    
    override public func layoutIfNeeded() {
        super.layoutSubviews()
        
        layoutAddButton()
    }
    
    func setup(with model: WalletModel) {
        emptyView.isHidden = model.isEmpty == false
        contentStackView.isHidden = model.isEmpty == true
        
        nameLabel.text = model.name
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
}
