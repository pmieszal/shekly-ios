//
//  WalletListRouter.swift
//  Shekly-generated
//
//  Created by Patryk Mieszała on 18/04/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

typealias WalletListRouterType = WalletListRouterProtocol & WalletListDataPassing

@objc protocol WalletListRouterProtocol {}

protocol WalletListDataPassing {
    var dataStore: WalletListDataStore { get }
}

final class WalletListRouter: WalletListDataPassing {
    // MARK: - Public Properties
    weak var viewController: WalletListViewController?
    var dataStore: WalletListDataStore

    // MARK: - Initializers
    init(viewController: WalletListViewController?, dataStore: WalletListDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}

extension WalletListRouter: WalletListRouterProtocol {}
