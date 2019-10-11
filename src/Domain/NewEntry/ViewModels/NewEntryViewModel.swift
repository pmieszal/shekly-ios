//
//  NewEntryViewModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 05/04/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import SwiftDate

import User
import Database
import Shared

public protocol NewEntryPresenter: AnyObject {
    func show(walletName: String?)
    func show(date: String?)
    func show(amount: String, color: UIColor)
    func setSaveButton(enabled: Bool)
    func reloadCategories(changeSet1: ChangeSet, changeSet2: ChangeSet)
    func reloadSubcategories(changeSet1: ChangeSet, changeSet2: ChangeSet)
    func dismiss()
}

public class NewEntryViewModel: SheklyViewModel {
    
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
        return currencyFormatter.numberParser.getNumber(fromString: amountString)
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
    
    // MARK: - Private properties
    private weak var presenter: NewEntryPresenter?
    private let dataController: SheklyDataController
    private let currencyFormatter: SheklyCurrencyFormatter
    private let differ: Differ
    
    // MARK: - Constructor
    init(
        presenter: NewEntryPresenter,
        dataController: SheklyDataController,
        currencyFormatter: SheklyCurrencyFormatter,
        differ: Differ,
        userProvider: UserManaging
        ) {
        
        self.presenter = presenter
        self.dataController = dataController
        self.currencyFormatter = currencyFormatter
        self.differ = differ
        
        let wallets = dataController.getWallets()
        let selectedWallet = wallets.filter { $0.id == userProvider.selectedWalletId }.first
        self.wallet = selectedWallet ?? wallets.first
        
        super.init()
        
        reloadAmount()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadSaveButton()
        presenter?.show(walletName: wallet?.name)
        presenter?.show(date: dateString)
    }
    
    public override func viewDidAppear() {
        super.viewDidAppear()
        
        reloadCategories()
    }
    
    public func didSelectSegmentedControl(itemAtIndex index: Int) {
        guard let entryType = WalletEntryType(rawValue: Int16(index)) else {
            return
        }
        
        self.entryType = entryType
        reloadAmount()
    }
    
    public func amountTextField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if range.length > 0, amountStringRaw.isEmpty == false {
            amountStringRaw.removeLast()
        } else if range.length == 0 {
            amountStringRaw.append(string)
        }
        
        reloadAmount()
        reloadSaveButton()
        
        return false
    }
    
    public func numberOfItemsInCategories(section: Int) -> Int {
        return NewEntryViewModel.getNumberOfItems(section: section, list: categories)
    }
    
    public func categoryTitle(forItemAt indexPath: IndexPath) -> String {
        return NewEntryViewModel.getItem(at: indexPath, list: categories).name ?? ""
    }
    
    public func didSelectCategory(at indexPath: IndexPath) {
        let sectionedList = NewEntryViewModel.getSectionedList(from: categories)
        let category = sectionedList[indexPath.section][indexPath.row]
        selectedCategory = category
        selectedSubcategory = nil
        
        reloadSubcategories(forCategory: category)
        reloadSaveButton()
    }
    
    public func numberOfItemsInSubcategories(section: Int) -> Int {
        return NewEntryViewModel.getNumberOfItems(section: section, list: subcategories)
    }
    
    public func subcategoryTitle(forItemAt indexPath: IndexPath) -> String {
        return NewEntryViewModel.getItem(at: indexPath, list: subcategories).name ?? ""
    }
    
    public func didSelectSubcategory(at indexPath: IndexPath) {
        let sectionedList = NewEntryViewModel.getSectionedList(from: subcategories)
        let subcategory = sectionedList[indexPath.section][indexPath.row]
        
        selectedSubcategory = subcategory
        reloadSaveButton()
    }
    
    public func commentTextViewDidChange(_ text: String) {
        comment = text
    }
    
    @objc
    public func save() {
        guard
            let wallet = wallet,
            let amount = amountNumber?.doubleValue,
            amount > 0,
            let selectedCategory = self.selectedCategory,
            let selectedSubcategory = self.selectedSubcategory
            else {
                return
        }
        
        let entry = WalletEntryModel(amount: amount,
                                     date: date,
                                     text: comment,
                                     type: entryType,
                                     wallet: wallet,
                                     category: selectedCategory,
                                     subcategory: selectedSubcategory,
                                     properties: nil)
        
        dataController.save(entry: entry)
        presenter?.dismiss()
    }
}

extension NewEntryViewModel: WalletListDelegate {
    public func didSelect(wallet: WalletModel) {
        self.wallet = wallet
        presenter?.show(walletName: wallet.name)
    }
}

extension NewEntryViewModel: DatePickerDelegate {
    public func didPick(date: Date) {
        self.date = date
        presenter?.show(date: dateString)
    }
}

// MARK: - Internal methods
extension NewEntryViewModel {
    func reloadCategories() {
        guard let wallet = self.wallet else {
            return
        }
        
        let categories = dataController.getCategories(forWallet: wallet)
        
        let oldState = self.categories
        self.categories = categories
        
        let oldSections = NewEntryViewModel.getSectionedList(from: oldState)
        let newSections = NewEntryViewModel.getSectionedList(from: categories)
        let changeSet1 = differ.getDiff(oldState: oldSections[0], newState: newSections[0])
        let changeSet2 = differ.getDiff(oldState: oldSections[1], newState: newSections[1])
        
        presenter?.reloadCategories(changeSet1: changeSet1, changeSet2: changeSet2)
    }
    
    func reloadSubcategories(forCategory category: CategoryModel) {
        let subcategories = self.dataController.getSubcategories(forCategory: category)
        
        let oldState = self.subcategories
        self.subcategories = subcategories
        
        let oldSections = NewEntryViewModel.getSectionedList(from: oldState)
        let newSections = NewEntryViewModel.getSectionedList(from: subcategories)
        let changeSet1 = differ.getDiff(oldState: oldSections[0], newState: newSections[0])
        let changeSet2 = differ.getDiff(oldState: oldSections[1], newState: newSections[1])
        
        presenter?.reloadSubcategories(changeSet1: changeSet1, changeSet2: changeSet2)
    }
    
    func reloadAmount() {
        presenter?.show(amount: amountWithCurrency ?? "", color: entryType.textColor)
    }
    
    func reloadSaveButton() {
        guard let amount = amountNumber?.doubleValue,
            amount > 0,
            selectedCategory != nil,
            selectedSubcategory != nil
            else {
                presenter?.setSaveButton(enabled: false)
                return
        }
        
        presenter?.setSaveButton(enabled: true)
    }
    
    class func getNumberOfItems<T>(section: Int, list: [T]) -> Int {
        let sectionedList = NewEntryViewModel.getSectionedList(from: list)
        
        return sectionedList[section].count
    }
    
    class func getItem<T>(at indexPath: IndexPath, list: [T]) -> T {
        let sectionedList = NewEntryViewModel.getSectionedList(from: list)
        
        return sectionedList[indexPath.section][indexPath.row]
    }
    
    class func getSectionedList<T>(from list: [T]) -> [[T]] {
        let middleIndexDouble = Double(list.count) / 2
        let middleIndex: Int = Int(middleIndexDouble.rounded(.up))
        
        let section1: [T] = Array(list.prefix(upTo: middleIndex))
        let section2: [T] = Array(list.suffix(from: middleIndex))
        
        return [section1, section2]
    }
}
