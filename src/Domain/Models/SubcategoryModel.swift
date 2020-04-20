//
//  SubcategoryModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 14/04/2020.
//

public struct SubcategoryModel {
    public let
    id: String?,
    name: String,
    wallet: SimplyWalletModel?,
    category: SimplyCategoryModel?
    
    public init(id: String?,
                name: String,
                wallet: SimplyWalletModel?,
                category: SimplyCategoryModel?) {
        self.id = id
        self.name = name
        self.wallet = wallet
        self.category = category
    }
}
