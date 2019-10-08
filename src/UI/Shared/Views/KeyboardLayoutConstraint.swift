//
//  KeyboardLayoutConstraint.swift
//  UI
//
//  Created by Patryk Mieszała on 07/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit

class KeyboardLayoutConstraint: NSLayoutConstraint {
    
    private var offset: CGFloat = 0
    private var keyboardVisibleHeight: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.offset = constant
        
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(KeyboardLayoutConstraint.keyboardWillShowNotification(_:)),
                         name: UIResponder.keyboardWillShowNotification,
                         object: nil)
        
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(KeyboardLayoutConstraint.keyboardWillHideNotification(_:)),
                         name: UIResponder.keyboardWillHideNotification,
                         object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Notification
    @objc func keyboardWillShowNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            if let frameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let frame = frameValue.cgRectValue
                
                self.keyboardVisibleHeight = frame.size.height
            }
            
            self.updateConstant()
            
        }
        
    }
    
    @objc func keyboardWillHideNotification(_ notification: Notification) {
        self.keyboardVisibleHeight = 0
        self.updateConstant()
    }
    
    func updateConstant() {
        self.constant = offset + keyboardVisibleHeight
    }
}
