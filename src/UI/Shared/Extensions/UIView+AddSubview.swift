//
//  UIView+AddSubview.swift
//  UI
//
//  Created by Patryk Mieszała on 20/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubviewWithMatchingConstraints(
        _ view: UIView,
        insets: UIEdgeInsets = .zero
        ) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        
        view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor, constant: insets.top).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom).isActive = true
    }
}
