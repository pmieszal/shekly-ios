//
//  WalletTokenModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 04/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation
import Database

public struct WalletTokenModel {
    public var label: String {
        return formatter.getLabel(fromToken: token, type: type)
    }
    
    public var color: UIColor {
        return type.color
    }
    
    var pureText: String {
        return formatter.pureText(fromToken: token, type: type)
    }
    
    var amount: Double {
        return formatter.getAmount(fromToken: token, type: type)
    }
    
    let type: SheklyTokenType
    let token: String
    let databaseProperties: DatabaseModelProperties?
    let formatter: SheklyTokenFormatter
    
    init(token: String, formatter: SheklyTokenFormatter) {
        self.type = SheklyTokenType(token: token, formatter: formatter)
        self.token = token
        self.databaseProperties = nil
        self.formatter = formatter
    }
    
    init(category: CategoryModel, formatter: SheklyTokenFormatter) {
        let type: SheklyTokenType = .hash
        
        self.type = type
        self.token = type.rawValue + (category.name ?? "")
        self.databaseProperties = category.properties
        self.formatter = formatter
    }
    
    init(subcategory: SubcategoryModel, formatter: SheklyTokenFormatter) {
        let type: SheklyTokenType = .at
        
        self.type = type
        self.token = type.rawValue + (subcategory.name ?? "")
        self.databaseProperties = subcategory.properties
        self.formatter = formatter
    }
    
    init(amount: Double, formatter: SheklyTokenFormatter) {
        let type: SheklyTokenType = .number
        
        self.type = type
        self.token = String(amount)
        self.databaseProperties = nil
        self.formatter = formatter
    }
    
    init?(text: String?, formatter: SheklyTokenFormatter) {
        guard let text = text else {
            return nil
        }
        
        let type: SheklyTokenType = .comment
        
        self.type = type
        self.token = formatter.getLabel(fromToken: text, type: type)
        self.databaseProperties = nil
        self.formatter = formatter
    }
}
