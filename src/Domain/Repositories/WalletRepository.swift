//
//  WalletRepository.swift
//  Domain
//
//  Created by Patryk Mieszała on 19/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

public protocol WalletRepository: AnyObject {
    func getWallets() -> [WalletModel]
    func save(wallet: WalletModel) -> WalletModel
}
