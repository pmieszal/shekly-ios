//
//  NewEntryCollectionCell.swift
//  UI
//
//  Created by Patryk Mieszała on 05/04/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Common

class NewEntryCollectionCell: UICollectionViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var label: UILabel!
    
    var text: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
        }
    }
    
    override var isSelected: Bool {
        get {
            return super.isSelected
        }
        set {
            super.isSelected = newValue
            set(selected: newValue)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupContainerViewBorder()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupContainerViewBorder()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        setupContainerViewBorder()
    }
}

private extension NewEntryCollectionCell {
    func setupContainerViewBorder() {
        containerView.layer.cornerRadius = contentView.bounds.height/2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.borderWidth = 1
        containerView.clipsToBounds = true
    }
    
    func set(selected: Bool) {
        containerView.backgroundColor = selected ? .white : .clear
        label.textColor = selected ? Colors.brandColor : .white
    }
}
