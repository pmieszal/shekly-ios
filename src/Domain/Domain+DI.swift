//
//  Domain+DI.swift
//  Domain
//
//  Created by Patryk Mieszała on 11/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Dip

public enum ContainerCustomName: String, DependencyTagConvertible {
    case emptyViewModel
}

public extension DependencyContainer {
    //swiftlint:disable:next function_body_length
    func configureDomain() -> DependencyContainer {
        unowned let container = self
        
        container.register(.unique,
                           tag: ContainerCustomName.emptyViewModel,
                           factory: { SheklyViewModel() })
        
        container.register(.unique,
                           factory: { presenter in
                            WalletViewModel(presenter: presenter,
                                            walletRepository: container.forceResolve(),
                                            walletEntriesRepository: container.forceResolve(),
                                            differ: container.forceResolve(),
                                            currencyFormatter: container.forceResolve(),
                                            userProvider: container.forceResolve())
        })
        
        container.register(.unique,
                           factory: { presenter, delegate in
                            WalletListViewModel(presenter: presenter,
                                                delegate: delegate,
                                                dataController: container.forceResolve())
        })
        
        container.register(.unique,
                           factory: { presenter in
                            PlanViewModel(presenter: presenter,
                                          dataController: container.forceResolve(),
                                          tokenFormatter: container.forceResolve(),
                                          userProvider: container.forceResolve())
        })
        
        container.register(.unique,
                           factory: { category in
                            CategoryViewModel(category: category,
                                              dataController: container.forceResolve(),
                                              currencyFormatter: container.forceResolve())
        })
        
        container.register(.unique,
                           factory: { delegate in
                            DatePickerViewModel(delegate: delegate)
        })
        
        // MARK: - Helpers
        container.register(.unique,
                           factory: {
                            WalletTokenFieldInputHelper(formatter: container.forceResolve())
        })
        
        container.register(.unique,
                           factory: {
                            SheklyTokenFormatter(localeProvider: container.forceResolve(),
                                                 numberParser: container.forceResolve())
        })
        
        container.register(.unique,
                           factory: {
                            SheklyCurrencyFormatter(localeProvider: container.forceResolve(),
                                                    numberParser: container.forceResolve())
        })
        
        container.register(.unique,
                           factory: { Differ() })
        
        return container
    }
}
