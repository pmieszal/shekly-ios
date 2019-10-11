//
//  SheklyTokenFormatter.swift
//  Domain
//
//  Created by Patryk Mieszała on 14/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

import Shared

class SheklyTokenFormatter {
    let localeProvider: LocaleProvider
    let numberParser: NumberParser
    
    init(localeProvider: LocaleProvider, numberParser: NumberParser) {
        self.localeProvider = localeProvider
        self.numberParser = numberParser
    }
    
    func getLabel(fromToken token: String, type: SheklyTokenType) -> String {
        if type == .number, let number = numberParser.getNumber(fromString: token) {
            let nf = NumberFormatter()
            nf.locale = localeProvider.locale
            nf.numberStyle = .currency
            nf.maximumFractionDigits = 2
            nf.minimumFractionDigits = 0
            
            return nf.string(from: number) ?? token
        }
        
        return token
    }
    
    func pureText(fromToken token: String, type: SheklyTokenType) -> String {
        switch type {
        case .hash, .at:
            if token.first == type.rawValue.first {
                var token = token
                token.removeFirst()
                
                return token
            }
            
            return token
        case .comment, .number:
            return token
        }
    }
    
    func getAmount(fromToken token: String, type: SheklyTokenType) -> Double {
        if type == .number, let number = numberParser.getNumber(fromString: token) {
            return Double(truncating: number)
        }
        
        return 0
    }
    
    func getNumber(fromToken token: String) -> NSNumber? {
        let number: NSNumber? = numberParser.getNumber(fromString: token)
        
        return number
    }
}
