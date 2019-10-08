//
//  UIViewController+KeyboardDismiss.swift
//  UI
//
//  Created by Patryk Mieszała on 05/04/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit

extension UIViewController {
    func setupTapGestureDismissingKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        self.view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
