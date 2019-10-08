//
//  SHTokenFieldDelegate.swift
//  SHTokenField
//
//  Created by Patryk Mieszała on 03/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

public protocol SHTokenFieldDelegate: class {
    
    func tokenField(tokenField: SHTokenField, shouldAddTokenNamed name: String) -> Bool
    func tokenField(tokenField: SHTokenField, shouldDeleteTokenAtIndex index: Int) -> Bool
    func tokenField(tokenField: SHTokenField, didDeleteTokenAtIndex index: Int)
    func tokenField(tokenField: SHTokenField, decideTokenPolicyForTextFieldAction action: SHTextFieldAction, decisionHandler: ((SHTextFieldActionPolicy) -> ()))
    func tokenField(tokenField: SHTokenField, textDidChange text: String?)
    
    func tokenField(tokenField: SHTokenField, didTapOn tokenView: SHTokenView, atIndex index: Int)
    func tokenField(tokenField: SHTokenField, didTapOnSuggestion tokenView: SHTokenView, atIndex index: Int)
}

public extension SHTokenFieldDelegate {
    
    func tokenField(tokenField: SHTokenField, shouldAddTokenNamed name: String) -> Bool {
        return true
    }
    
    func tokenField(tokenField: SHTokenField, shouldDeleteTokenAtIndex index: Int) -> Bool {
        return true
    }
    
    func tokenField(tokenField: SHTokenField, didDeleteTokenAtIndex index: Int) {
        
    }
    
    func tokenField(tokenField: SHTokenField, textDidChange text: String?) {
        
    }
    
    func tokenField(tokenField: SHTokenField, didTapOn tokenView: SHTokenView, atIndex index: Int) {
        
    }
    
    func tokenField(tokenField: SHTokenField, didTapOnSuggestion tokenView: SHTokenView, atIndex index: Int) {
        
    }
}
