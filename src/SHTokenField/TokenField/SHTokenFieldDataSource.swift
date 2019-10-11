//
//  SHTokenFieldDataSource.swift
//  SHTokenField
//
//  Created by Patryk Mieszała on 03/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

public protocol SHTokenFieldDataSource: AnyObject {
    
    func numberOfTokensInTokenField(tokenField: SHTokenField) -> Int
    func tokenField(tokenField: SHTokenField, viewForTokenAtIndex index: Int) -> SHTokenView
    
    func numberOfTokenSuggestions(tokenField: SHTokenField) -> Int
    func tokenField(tokenField: SHTokenField, viewForTokenSuggestionAtIndex index: Int) -> SHTokenView
    
}

public extension SHTokenFieldDataSource {
    
    func numberOfTokenSuggestions(tokenField: SHTokenField) -> Int {
        return 0
    }
    
    func tokenField(tokenField: SHTokenField, viewForTokenSuggestionAtIndex index: Int) -> SHTokenView {
        return SHTokenView()
    }
}
