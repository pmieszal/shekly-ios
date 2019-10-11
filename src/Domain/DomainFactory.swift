//
//  DomainFactory.swift
//  Domain
//
//  Created by Patryk Mieszała on 03/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import User
import Database
import Shared

//TODO: get rid of this
public struct DomainFactory {
    let userFactory: UserFactory
    let databaseFactory: DatabaseFactory
    let sharedFactory: SharedFactory
    
    public init(
        userFactory: UserFactory,
        databaseFactory: DatabaseFactory,
        sharedFactory: SharedFactory
        ) {
        self.userFactory = userFactory
        self.databaseFactory = databaseFactory
        self.sharedFactory = sharedFactory
    }
}

public extension DomainFactory {
    func getEmptyViewModel() -> SheklyViewModel {
        return SheklyViewModel()
    }
    
    func getWalletViewModel(presenter: WalletPresenter) -> WalletViewModel {
        return WalletViewModel(
            presenter: presenter,
            dataController: databaseFactory.getDataController(),
            differ: getDiffer(),
            currencyFormatter: getCurrencyFormatter(),
            userProvider: userFactory.getUserProvider())
    }
    
    func getPlanViewModel(categorySelectionHandler: @escaping PlanViewModel.CategorySelectionHandler) -> PlanViewModel {
        return PlanViewModel(
            categorySelectionHandler: categorySelectionHandler,
            dataController: databaseFactory.getDataController(),
            tokenFormatter: getTokenFormatter(),
            userProvider: userFactory.getUserProvider())
    }
    
    func getCategoryViewModel(category: SheklyCategoryModel) -> CategoryViewModel {
        return CategoryViewModel(
            category: category,
            dataController: databaseFactory.getDataController(),
            currencyFormatter: getCurrencyFormatter())
    }
    
    func getNewEntryViewModel(presenter: NewEntryPresenter) -> NewEntryViewModel {
        return NewEntryViewModel(
            presenter: presenter,
            dataController: databaseFactory.getDataController(),
            currencyFormatter: getCurrencyFormatter(),
            differ: getDiffer(),
            userProvider: userFactory.getUserProvider())
    }
    
    func getWalletListViewModel(
        presenter: WalletListPresenter,
        delegate: WalletListDelegate) -> WalletListViewModel {
        return WalletListViewModel(
            presenter: presenter,
            delegate: delegate,
            dataController: databaseFactory.getDataController())
    }
    
    func getDatePickerViewModel(delegate: DatePickerDelegate) -> DatePickerViewModel {
        return DatePickerViewModel(delegate: delegate)
    }
}

extension DomainFactory {
    
    func getWalletTokenFieldInputHelper() -> WalletTokenFieldInputHelper {
        return WalletTokenFieldInputHelper(formatter: getTokenFormatter())
    }
    
    func getTokenFormatter() -> SheklyTokenFormatter {
        return SheklyTokenFormatter(localeProvider: sharedFactory.getLocaleProvider(), numberParser: sharedFactory.getNumberParser())
    }
    
    func getCurrencyFormatter() -> SheklyCurrencyFormatter {
        return SheklyCurrencyFormatter(localeProvider: sharedFactory.getLocaleProvider(), numberParser: sharedFactory.getNumberParser())
    }
    
    func getDiffer() -> Differ {
        return Differ()
    }
}
