//
//  SheklyButton.swift
//  UI
//
//  Created by Patryk Mieszała on 07/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit

class SheklyButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var rounded: Bool = false {
        didSet {
            guard rounded == true else { return }
            
            self.layer.cornerRadius = self.frame.height / 2
            self.clipsToBounds = true
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if rounded == true {
            self.layer.cornerRadius = self.frame.height / 2
            self.clipsToBounds = true
        }
    }
}
