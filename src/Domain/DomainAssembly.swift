//
//  DomainAssembly.swift
//  Domain
//
//  Created by Patryk Mieszała on 11/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Swinject
import Database
import User
import Shared

public enum ContainerCustomName: String {
    case emptyViewModel
}

public extension Container {
    @discardableResult
    func register<Service>(_ serviceType: Service.Type,
                           name: ContainerCustomName,
                           factory: @escaping (Resolver) -> Service) -> ServiceEntry<Service> {
        return register(serviceType, name: name.rawValue, factory: factory)
    }
}

public class DomainAssembly: Assembly {
    public init() { }
    
    public func assemble(container: Container) {
        container.registerHelpers()
        
        container.register(SheklyViewModel.self,
                           name: ContainerCustomName.emptyViewModel,
                           factory: { _ in SheklyViewModel() })
        
        container.register(WalletViewModel.self,
                           factory: { r, presenter in
                            WalletViewModel(presenter: presenter,
                                            dataController: r.forceResolve(),
                                            differ: r.forceResolve(),
                                            currencyFormatter: r.forceResolve(),
                                            userProvider: r.forceResolve())
        })
        
        container.register(WalletListViewModel.self,
                           factory: { r, presenter, delegate in
                            WalletListViewModel(presenter: presenter,
                                                delegate: delegate,
                                                dataController: r.forceResolve())
        })
        
        container.register(PlanViewModel.self,
                           factory: { r, handler in
                            PlanViewModel(categorySelectionHandler: handler,
                                          dataController: r.forceResolve(),
                                          tokenFormatter: r.forceResolve(),
                                          userProvider: r.forceResolve())
        })
        
        container.register(CategoryViewModel.self,
                           factory: { r, category in
                            CategoryViewModel(category: category,
                                              dataController: r.forceResolve(),
                                              currencyFormatter: r.forceResolve())
        })
        
        container.register(NewEntryViewModel.self,
                           factory: { r, presenter in
                            NewEntryViewModel(presenter: presenter,
                                              dataController: r.forceResolve(),
                                              currencyFormatter: r.forceResolve(),
                                              differ: r.forceResolve(),
                                              userProvider: r.forceResolve())
        })
        
        container.register(DatePickerViewModel.self,
                           factory: { _, delegate in
                            DatePickerViewModel(delegate: delegate)
        })
    }
}

private extension Container {
    func registerHelpers() {
        let container = self
        
        container.register(WalletTokenFieldInputHelper.self,
                            factory: { r in
                                WalletTokenFieldInputHelper(formatter: r.forceResolve())
        })
        
        container.register(SheklyTokenFormatter.self,
                            factory: { r in
                                SheklyTokenFormatter(localeProvider: r.forceResolve(),
                                                     numberParser: r.forceResolve())
        })
        
        container.register(SheklyCurrencyFormatter.self,
                            factory: { r in
                                SheklyCurrencyFormatter(localeProvider: r.forceResolve(),
                                                        numberParser: r.forceResolve())
        })
        
        container.register(Differ.self,
                            factory: { _ in
                                Differ()
        })
    }
}
