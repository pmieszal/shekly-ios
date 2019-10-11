//
//  UITabBarItem+Bootstrap.swift
//  UI
//
//  Created by Patryk Mieszała on 18/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Shared

public extension Bootstrap {
    
    static func tabBarItemAppearance() {
        
        let normalAtts: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: .regular),
            NSAttributedString.Key.foregroundColor: Colors.text1Color
        ]
        
        UITabBarItem.appearance().setTitleTextAttributes(normalAtts, for: .normal)
        
        let highlightedAtts: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: .regular),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        UITabBarItem.appearance().setTitleTextAttributes(highlightedAtts, for: .selected)
    }
}
