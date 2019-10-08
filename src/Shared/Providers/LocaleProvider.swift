//
//  LocaleProvider.swift
//  Domain
//
//  Created by Patryk Mieszała on 14/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

public class LocaleProvider {
    
    public var locale: Locale {
        
        let preferredLanguages: [String] = Locale.preferredLanguages
        
        for lang in preferredLanguages {
            if lang.count > 2 {
                let locale: Locale = Locale(identifier: lang)
                
                return locale
            }
        }
        
        return Locale.current
    }
}
