//
//  WalletModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 23/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

public struct WalletModel: Equatable, Hashable {
    public let
    id: String?,
    name: String?,
    entries: [WalletEntryModel]
    
    public var isEmpty: Bool { id == nil }
    
    public init(id: String?,
                name: String?,
                entries: [WalletEntryModel]) {
        self.id = id
        self.name = name
        self.entries = entries
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id ?? NSUUID().uuidString)
    }
}

public func == (lhs: WalletModel, rhs: WalletModel) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
