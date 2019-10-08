//
//  SHTextFieldAction.swift
//  SHTokenField
//
//  Created by Patryk Mieszała on 05/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

open class SHTextFieldAction {
    
    public let currentText: String
    public let stringChange: String
    public let range: NSRange
    public let keyboardType: UIKeyboardType
    
    init(
        currentText: String,
        stringChange: String,
        range: NSRange,
        keyboardType: UIKeyboardType
        ) {
        self.currentText = currentText
        self.stringChange = stringChange
        self.range = range
        self.keyboardType = keyboardType
    }
}
