//
//  GradientMaskView.swift
//  UI
//
//  Created by Patryk Mieszała on 02/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit

class GradientMaskView: UIView {
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        self.setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setup()
    }
    
    func setup() {
        let colors: [CGColor] = [UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor]
        let locations: [NSNumber] = [0.0, 0.4, 0.7, 1]
        
        self.setupGradient(colors: colors, locations: locations)
    }
    
    func setupGradient(colors: [CGColor], locations: [NSNumber]) {
        let gradient = CAGradientLayer()
        
        gradient.frame = self.bounds
        gradient.colors = colors
        gradient.locations = locations
        
        self.layer.mask = gradient
    }
}


