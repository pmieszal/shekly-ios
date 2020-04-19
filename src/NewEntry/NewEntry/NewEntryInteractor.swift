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
    var entryType: WalletEntryType = .outcome
    
    var amountStringRaw: String = ""
    var amountString: String {
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
    var amountWithCurrency: String? {
        let amount: String = amountString.isEmpty ? "0" : amountString
        
        guard let formattedAmount = currencyFormatter.getCurrencyString(fromString: amount) else {
            return nil
        }
        
        return entryType.textPrefix + " " + formattedAmount
    }
    var amountNumber: NSNumber? {
        return numberParser.getNumber(fromString: amountString)
    }
    
    var date: Date = Date()
    var dateString: String {
        return date.toString(DateToStringStyles.date(DateFormatter.Style.short))
    }
    
    var categories: [CategoryModel] = []
    var subcategories: [SubcategoryModel] = []
    
    var selectedCategory: CategoryModel?
    var selectedSubcategory: SubcategoryModel?
    
    var comment: String?
    
    var wallet: WalletModel?
    
    var presenter: NewEntryPresenterLogic
    //let dataController: SheklyDataController
    let currencyFormatter: SheklyCurrencyFormatter
    let numberParser: NumberParser
    let differ: Differ
    
    // MARK: - Constructor
    init(presenter: NewEntryPresenter,
         //dataController: SheklyDataController,
         currencyFormatter: SheklyCurrencyFormatter,
         differ: Differ,
         numberParser: NumberParser,
         userProvider: UserManaging) {
        
        self.presenter = presenter
        //self.dataController = dataController
        self.currencyFormatter = currencyFormatter
        self.numberParser = numberParser
        self.differ = differ
        
        let wallets = [WalletModel]() // dataController.getWallets()
        let selectedWallet = wallets.filter { $0.id == userProvider.selectedWalletId }.first
        self.wallet = selectedWallet ?? wallets.first
    }
}

extension NewEntryInteractor: NewEntryInteractorLogic {
    var walletListDelegate: WalletListDelegate { self }
    var datePickerDelegate: DatePickerDelegate { self }
    
    func didSelectSegmentedControl(itemAtIndex index: Int) {
        guard let entryType = WalletEntryType(rawValue: index) else {
            return
        }
        
        self.entryType = entryType
        reloadAmount()
    }
    
    func amountTextField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
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
        
        //TODO: this
//        let entry = WalletEntryModel(amount: amount,
//                                     date: date,
//                                     text: comment,
//                                     type: entryType,
//                                     wallet: wallet,
//                                     category: selectedCategory,
//                                     subcategory: selectedSubcategory,
//                                     properties: nil)
//
//        dataController.save(entry: entry)
        
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
