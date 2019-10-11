//
//  NewEntryCollectionCell.swift
//  UI
//
//  Created by Patryk Mieszała on 05/04/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Shared

class NewEntryCollectionCell: UICollectionViewCell {

    @IBOutlet private weak var ibContentView: UIView!
    @IBOutlet private weak var ibLabel: UILabel!
    
    var text: String? {
        get {
            return ibLabel.text
        }
        set {
            ibLabel.text = newValue
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
        
        setupContentViewBorder()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupContentViewBorder()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        setupContentViewBorder()
    }
}

private extension NewEntryCollectionCell {
    func setupContentViewBorder() {
        ibContentView.layer.cornerRadius = ibContentView.bounds.height/2
        ibContentView.layer.borderColor = UIColor.white.cgColor
        ibContentView.layer.borderWidth = 1
        ibContentView.clipsToBounds = true
    }
    
    func set(selected: Bool) {
        ibContentView.backgroundColor = selected ? .white : .clear
        ibLabel.textColor = selected ? Colors.brandColor : .white
    }
}
