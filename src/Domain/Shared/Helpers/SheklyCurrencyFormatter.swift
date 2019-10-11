//
//  SheklyCurrencyFormatter.swift
//  Domain
//
//  Created by Patryk Mieszała on 23/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

import Shared

class SheklyCurrencyFormatter {
    let localeProvider: LocaleProvider
    let numberParser: NumberParser
    
    init(localeProvider: LocaleProvider, numberParser: NumberParser) {
        self.localeProvider = localeProvider
        self.numberParser = numberParser
    }
    
    func getCurrencyString(fromString string: String) -> String? {
        guard let number = numberParser.getNumber(fromString: string) else {
            return nil
        }
        
        let nf = NumberFormatter()
        nf.locale = localeProvider.locale
        nf.numberStyle = .currency
        nf.maximumFractionDigits = 2
        nf.minimumFractionDigits = 2
        
        return nf.string(from: number)
    }
    
    func getCurrencyString(fromNumber number: NSNumber) -> String? {
        let nf = NumberFormatter()
        nf.locale = localeProvider.locale
        nf.numberStyle = .currency
        nf.maximumFractionDigits = 2
        nf.minimumFractionDigits = 2
        
        return nf.string(from: number)
    }
    
    func getCurrencyString(fromNumber number: Double) -> String? {
        return getCurrencyString(fromNumber: number as NSNumber)
    }
}
