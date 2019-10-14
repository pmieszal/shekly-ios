//
//  Domain+DI.swift
//  Domain
//
//  Created by Patryk Mieszała on 11/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Dip
import Database
import User
import Shared

public enum ContainerCustomName: String, DependencyTagConvertible {
    case emptyViewModel
}

public extension DependencyContainer {
    static func configureDomain() -> DependencyContainer {
        return DependencyContainer { container in
            container.register(.unique,
                               tag: ContainerCustomName.emptyViewModel,
                               factory: { SheklyViewModel() })
            
            container.register(.unique,
                               factory: { presenter in
                                WalletViewModel(presenter: presenter,
                                                dataController: container.forceResolve(),
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
                               factory: { handler in
                                PlanViewModel(categorySelectionHandler: handler,
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
                               factory: { presenter in
                                NewEntryViewModel(presenter: presenter,
                                                  dataController: container.forceResolve(),
                                                  currencyFormatter: container.forceResolve(),
                                                  differ: container.forceResolve(),
                                                  userProvider: container.forceResolve())
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
        }
    }
}
