//
//  WalletTokenFieldInputHelper.swift
//  Domain
//
//  Created by Patryk Mieszała on 05/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import SHTokenField

class WalletTokenFieldInputHelper {
    let formatter: SheklyTokenFormatter
    
    init(formatter: SheklyTokenFormatter) {
        self.formatter = formatter
    }
    
    func decideTokenPolicy(forTextFieldAction action: SHTextFieldAction, decisionHandler: ((SHTextFieldActionPolicy) -> ())) {
        let tokenType: SheklyTokenType
        
        if action.currentText.count > 0 {
            let newText = action.currentText + action.stringChange
            
            tokenType = SheklyTokenType(token: newText, formatter: formatter)
        } else {
            tokenType = SheklyTokenType(token: action.stringChange, formatter: formatter)
        }
        
        if action.stringChange.isEmpty == true,
            action.currentText.count == 1 {
            decisionHandler(.setTwitterKeyboardType)
        } else if tokenType != .number,
            action.keyboardType == .twitter {
            decisionHandler(.setDefaultKeyboardType)
        }
    }
}
