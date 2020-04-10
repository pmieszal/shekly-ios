//
//  NewEntry+DI.swift
//  NewEntry
//
//  Created by Patryk Mieszała on 10/04/2020.
//

import Dip

public extension DependencyContainer {
    //swiftlint:disable:next function_body_length
    func configureNewEntry() -> DependencyContainer {
        unowned let container = self
        
        container.register(.unique, factory: { NewEntryConfigurator() })
        container.register(.unique, factory: { NewEntryRouter(viewController: $0) })
        
        container.register(.unique,
                           factory: { presenter in
                            NewEntryViewModel(presenter: presenter,
                                              dataController: container.forceResolve(),
                                              currencyFormatter: container.forceResolve(),
                                              differ: container.forceResolve(),
                                              userProvider: container.forceResolve())
        })
    }
}
