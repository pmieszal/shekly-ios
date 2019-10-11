//
//  SheklyNavigationController.swift
//  UI
//
//  Created by Patryk Mieszała on 03/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Shared

class SheklyNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        navigationBar.tintColor = Colors.brandColor
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: Colors.brandColor,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        ]

        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
    }
}
