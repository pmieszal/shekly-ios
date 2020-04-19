//
//  SubcategoryModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 14/04/2020.
//

import Foundation

public struct SubcategoryModel {
    public let
    id: String?,
    name: String,
    wallet: WalletModel?,
    category: CategoryModel?
    
    public init(id: String?,
                name: String,
                wallet: WalletModel?,
                category: CategoryModel?) {
        self.id = id
        self.name = name
        self.wallet = wallet
        self.category = category
    }
}
