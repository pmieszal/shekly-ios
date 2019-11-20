//
//  WalletListDelegateMock.swift
//  DomainTests
//
//  Created by Patryk Mieszała on 20/11/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Domain
import Database

class WalletListDelegateMock: WalletListDelegate {
    var didSelectHandler: ((WalletModel) -> ())?
    
    func didSelect(wallet: WalletModel) {
        didSelectHandler?(wallet)
    }
}
