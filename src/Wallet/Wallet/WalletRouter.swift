//
//  WalletRouter.swift
//  Shekly-generated
//
//  Created by Patryk Mieszała on 16/04/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

typealias WalletRouterType = WalletRouterProtocol & WalletDataPassing

@objc protocol WalletRouterProtocol {}

protocol WalletDataPassing {
    var dataStore: WalletDataStore { get }
}

final class WalletRouter: WalletDataPassing {
    // MARK: - Public Properties
    weak var viewController: WalletViewController?
    var dataStore: WalletDataStore

    // MARK: - Initializers
    init(viewController: WalletViewController?, dataStore: WalletDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}

extension WalletRouter: WalletRouterProtocol {}
