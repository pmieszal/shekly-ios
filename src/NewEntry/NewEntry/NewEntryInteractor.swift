//
//  NewEntryInteractor.swift
//  Shekly-generated
//
//  Created by Patryk Mieszała on 17/04/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SwiftDate
import CleanArchitectureHelpers
import User
import Common
import CommonUI
import Domain

@objc
protocol NewEntryInteractorLogic: InteractorLogic {
    func didSelectSegmentedControl(itemAtIndex index: Int)
    func amountTextField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    
    func didSelectCategory(id: String)
    func didSelectSubcategory(id: String)
    
    func commentTextViewDidChange(_ text: String)
    func save()
}

protocol NewEntryDataStore {
    var walletListDelegate: WalletListDelegate { get }
    var datePickerDelegate: DatePickerDelegate { get }
}

final class NewEntryInteractor: NewEntryDataStore {
    // MARK: - Internal properties
    private var entryType: WalletEntryType = .outcome
    
    private var amountStringRaw: String = ""
    private var amountString: String {
        guard amountStringRaw.isEmpty == false else {
            return amountStringRaw
        }
        
        if amountStringRaw.count < 2 {
            return "0.0" + amountStringRaw
        }
        
        if amountStringRaw.count < 3 {
            return "0." + amountStringRaw
        }
        
        let index = amountStringRaw.index(amountStringRaw.endIndex, offsetBy: -2)
        let normalPart = amountStringRaw.prefix(upTo: index)
        let decimalPart = amountStringRaw.suffix(from: index)
        
        return normalPart + "." + decimalPart
    }
    private var amountWithCurrency: String? {
        let amount: String = amountString.isEmpty ? "0" : amountString
        
        guard let formattedAmount = currencyFormatter.getCurrencyString(fromString: amount) else {
            return nil
        }
        
        return entryType.textPrefix + " " + formattedAmount
    }
    private var amountNumber: NSNumber? {
        return numberParser.getNumber(fromString: amountString)
    }
    
    private var date: Date = Date()
    private var dateString: String {
        return date.toString(DateToStringStyles.date(DateFormatter.Style.short))
    }
    
    private var categories: [CategoryModel] = []
    private var subcategories: [SubcategoryModel] = []
    
    private var selectedCategory: CategoryModel?
    private var selectedSubcategory: SubcategoryModel?
    
    private var comment: String?
    
    private var wallet: WalletModel?
    
    private var presenter: NewEntryPresenterLogic
    private let currencyFormatter: SheklyCurrencyFormatter
    private let numberParser: NumberParser
    
    private let getWalletsUseCase: GetWalletsUseCase
    
    // MARK: - Constructor
    init(presenter: NewEntryPresenter,
         currencyFormatter: SheklyCurrencyFormatter,
         numberParser: NumberParser,
         userProvider: UserManaging) {
        
        self.presenter = presenter
        self.currencyFormatter = currencyFormatter
        self.numberParser = numberParser
    }
}

extension NewEntryInteractor: NewEntryInteractorLogic {
    var walletListDelegate: WalletListDelegate { self }
    var datePickerDelegate: DatePickerDelegate { self }
    
    func viewDidLoad() {
        reload()
    }
    
    func didSelectSegmentedControl(itemAtIndex index: Int) {
        guard let entryType = WalletEntryType(rawValue: index) else {
            return
        }
        
        self.entryType = entryType
        reloadAmount()
    }
    
    func amountTextField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {
        
        if range.length > 0, amountStringRaw.isEmpty == false {
            amountStringRaw.removeLast()
        } else if range.length == 0 {
            amountStringRaw.append(string)
        }
        
        reloadAmount()
        reloadSaveButton()
        
        return false
    }
    
    func didSelectCategory(id: String) {
        guard let category = categories.first(where: { $0.id == id }) else {
            return
        }
        
        selectedCategory = category
        selectedSubcategory = nil
        
        reloadSubcategories(forCategory: category)
        reloadSaveButton()
    }
    
    func didSelectSubcategory(id: String) {
        guard let subcategory = subcategories.first(where: { $0.id == id }) else {
            return
        }
        
        selectedSubcategory = subcategory
        reloadSaveButton()
    }
    
    func commentTextViewDidChange(_ text: String) {
        comment = text
    }
    
    func save() {
        guard let wallet = wallet,
            let amount = amountNumber?.doubleValue,
            amount > 0,
            let selectedCategory = self.selectedCategory,
            let selectedSubcategory = self.selectedSubcategory
            else {
                return
        }
        
        let entry = WalletEntryModel(
            id: nil,
            type: entryType,
            text: comment ?? "",
            date: date,
            amount: amount,
            wallet: SimplyWalletModel(wallet: wallet),
            category: SimplyCategoryModel(category: selectedCategory),
            subcategory: SimplySubcategoryModel(subcategory: selectedSubcategory))

        //TODO: this
        //dataController.save(entry: entry)
        
        presenter.dismiss()
    }
}

extension NewEntryInteractor: WalletListDelegate {
    public func didSelect(wallet: WalletModel) {
        self.wallet = wallet
        presenter.show(walletName: wallet.name)
    }
}

extension NewEntryInteractor: DatePickerDelegate {
    public func didPick(date: Date) {
        self.date = date
        presenter.show(date: dateString)
    }
}

// MARK: - Private methods
private extension NewEntryInteractor {
    func reload() {
        reloadCurrentWallet {
            self.reloadCategories()
        }
    }
    
    func reloadCurrentWallet(completion: (() -> Void)?) {
        getWalletsUseCase.getCurrentWallet(
            success: { [weak self] (currentWallet) in
                self?.wallet = currentWallet
                completion?()
            },
            failure: presenter.show(error:))
    }
    
    func reloadCategories() {
        guard let wallet = self.wallet else {
            return
        }
        
        //TODO: this
//        let categories = dataController.getCategories(forWallet: wallet)
//
//        let oldState = self.categories
//        self.categories = categories
//
//        let oldSections = NewEntryViewModel.getSectionedList(from: oldState)
//        let newSections = NewEntryViewModel.getSectionedList(from: categories)
//        let changeSet1 = differ.getDiff(oldState: oldSections[0], newState: newSections[0])
//        let changeSet2 = differ.getDiff(oldState: oldSections[1], newState: newSections[1])
//
//        presenter.reloadCategories(changeSet1: changeSet1, changeSet2: changeSet2)
    }
    
    func reloadSubcategories(forCategory category: CategoryModel) {
        //TODO: this
//        let subcategories = self.dataController.getSubcategories(forCategory: category)
//
//        let oldState = self.subcategories
//        self.subcategories = subcategories
//
//        let oldSections = NewEntryViewModel.getSectionedList(from: oldState)
//        let newSections = NewEntryViewModel.getSectionedList(from: subcategories)
//        let changeSet1 = differ.getDiff(oldState: oldSections[0], newState: newSections[0])
//        let changeSet2 = differ.getDiff(oldState: oldSections[1], newState: newSections[1])
//
//        presenter.reloadSubcategories(changeSet1: changeSet1, changeSet2: changeSet2)
    }
    
    func reloadAmount() {
        presenter.show(amount: amountWithCurrency ?? "", color: entryType.textColor)
    }
    
    func reloadSaveButton() {
        guard let amount = amountNumber?.doubleValue,
            amount > 0,
            selectedCategory != nil,
            selectedSubcategory != nil
            else {
                presenter.setSaveButton(enabled: false)
                return
        }
        
        presenter.setSaveButton(enabled: true)
    }
}
