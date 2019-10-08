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
import RxSwift
import RxCocoa

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
    
    public func getEmptyViewModel(disposeBag: DisposeBag) -> SheklyViewModel {
        return SheklyViewModel()
    }
    
    public func getWalletViewModel(
        presenter: WalletPresenter,
        disposeBag: DisposeBag
        ) -> WalletViewModel {
        
        return WalletViewModel(
            presenter: presenter,
            dataController: databaseFactory.getDataController(),
            differ: getDiffer(),
            currencyFormatter: getCurrencyFormatter(),
            userProvider: userFactory.getUserProvider())
    }
    
    public func getPlanViewModel(
        categorySelectionHandler: @escaping PlanViewModel.CategorySelectionHandler,
        disposeBag: DisposeBag
        ) -> PlanViewModel {
        
        return PlanViewModel(
            categorySelectionHandler: categorySelectionHandler,
            dataController: databaseFactory.getDataController(),
            tokenFormatter: getTokenFormatter(),
            userProvider: userFactory.getUserProvider())
    }
    
    public func getCategoryViewModel(
        category: SheklyCategoryModel,
        disposeBag: DisposeBag
        ) -> CategoryViewModel {
        
        return CategoryViewModel(
            category: category,
            dataController: databaseFactory.getDataController(),
            currencyFormatter: getCurrencyFormatter())
    }
    
    public func getNewEntryViewModel(
        presenter: NewEntryPresenter,
        disposeBag: DisposeBag
        ) -> NewEntryViewModel {
        return NewEntryViewModel(
            presenter: presenter,
            dataController: databaseFactory.getDataController(),
            currencyFormatter: getCurrencyFormatter(),
            differ: getDiffer(),
            userProvider: userFactory.getUserProvider())
    }
    
    public func getWalletListViewModel(
        presenter: WalletListPresenter,
        delegate: WalletListDelegate,
        disposeBag: DisposeBag
        ) -> WalletListViewModel {
        return WalletListViewModel(
            presenter: presenter,
            delegate: delegate,
            dataController: databaseFactory.getDataController())
    }
    
    public func getDatePickerViewModel(
        delegate: DatePickerDelegate
        ) -> DatePickerViewModel {
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
