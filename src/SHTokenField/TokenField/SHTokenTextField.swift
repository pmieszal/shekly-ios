//
//  SHTokenTextField.swift
//  SHTokenField
//
//  Created by Patryk Mieszała on 03/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit

class SHTokenTextField: SHTextField {
    
    var deleteBackwardCallback: (() -> ())?
    
    override func deleteBackward() {
        let textBeforeDelete = text
        super.deleteBackward()
        
        guard textBeforeDelete?.isEmpty == true else {
            return
        }
        
        deleteBackwardCallback?()
    }
    
    override func setupAtts() {
        let textAtts: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .light),
            NSAttributedString.Key.foregroundColor: UIColor(hex: 0x000080)
        ]
        
        defaultTextAttributes = textAtts
        
        let placeholderAtts: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .ultraLight),
            NSAttributedString.Key.foregroundColor: UIColor(hex: 0x19198c)
        ]
        
        let attPlaceholder = NSAttributedString(string: "#shekly", attributes: placeholderAtts)
        
        attributedPlaceholder = attPlaceholder
    }
}
