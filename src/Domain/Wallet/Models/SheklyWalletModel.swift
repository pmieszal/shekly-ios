//
//  SheklyWalletModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 23/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Database

public class SheklyWalletModel: Equatable, Hashable {
    public let name: String?
    public let isEmpty: Bool
    
    var id: String? {
        return wallet?.id
    }
    
    let wallet: WalletModel?
    
    init(wallet: WalletModel?) {
        self.wallet = wallet
        
        self.name = wallet?.name
        self.isEmpty = wallet == nil
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id ?? NSUUID().uuidString)
    }
}

public func == (lhs: SheklyWalletModel, rhs: SheklyWalletModel) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
