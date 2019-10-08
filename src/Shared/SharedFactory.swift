//
//  SharedFactory.swift
//  Domain
//
//  Created by Patryk Mieszała on 14/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

public struct SharedFactory {
    
    public init() { }
    
    public func getLocaleProvider() -> LocaleProvider {
        return LocaleProvider()
    }
    
    public func getNumberParser() -> NumberParser {
        return NumberParser()
    }
}
