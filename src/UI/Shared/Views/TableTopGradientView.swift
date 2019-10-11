//
//  TableTopGradientView.swift
//  UI
//
//  Created by Patryk Mieszała on 26/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit

class TableTopGradientView: GradientMaskView {
    
    override func setup() {
        let colors: [CGColor] = [UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor]
        let locations: [NSNumber] = [0.0, 0.4, 0.7, 1]
        
        setupGradient(colors: colors, locations: locations)
    }
}
