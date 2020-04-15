//
//  SheklyWalletModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 23/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

public struct SheklyWalletModel: Equatable, Hashable {
    public let
    name: String?,
    id: String?
    
    //TODO: get rid of this, this logic should be in UI module
    public var isEmpty: Bool { id == nil }
    
    public init(name: String?,
                id: String?) {
        self.name = name
        self.id = id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id ?? NSUUID().uuidString)
    }
}

public func == (lhs: SheklyWalletModel, rhs: SheklyWalletModel) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
