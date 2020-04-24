import CleanArchitectureHelpers
import Common
import CommonUI
import Domain
import SwiftDate
import UIKit
import User

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
    private let getCategoriesUseCase: GetCategoriesUseCase
    private let getSubcategoriesUseCase: GetSubcategoriesUseCase
    private let saveEntryUseCase: SaveWalletEntryUseCase
    
    // MARK: - Constructor
    
    init(presenter: NewEntryPresenter,
         currencyFormatter: SheklyCurrencyFormatter,
         numberParser: NumberParser,
         getWalletsUseCase: GetWalletsUseCase,
         saveEntryUseCase: SaveWalletEntryUseCase,
         getCategoriesUseCase: GetCategoriesUseCase,
         getSubcategoriesUseCase: GetSubcategoriesUseCase) {
        self.presenter = presenter
        self.currencyFormatter = currencyFormatter
        self.numberParser = numberParser
        self.getWalletsUseCase = getWalletsUseCase
        self.saveEntryUseCase = saveEntryUseCase
        self.getCategoriesUseCase = getCategoriesUseCase
        self.getSubcategoriesUseCase = getSubcategoriesUseCase
    }
}

extension NewEntryInteractor: NewEntryInteractorLogic {
    var walletListDelegate: WalletListDelegate { self }
    var datePickerDelegate: DatePickerDelegate { self }
    
    func viewDidLoad() {
        reload()
        presenter.show(date: dateString)
    }
    
    func didSelectSegmentedControl(itemAtIndex index: Int) {
        guard let entryType = WalletEntryType(rawValue: index) else {
            return
        }
        
        self.entryType = entryType
        reloadAmount()
    }
    
    func amountTextField(_ textField: UITextField,
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
        
        saveEntryUseCase.save(
            entry: entry,
            success: presenter.dismiss,
            failure: presenter.show(error:))
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
            self.reloadAmount()
        }
    }
    
    func reloadCurrentWallet(completion: (() -> Void)?) {
        getWalletsUseCase.getCurrentWallet(
            success: { [weak self] currentWallet in
                self?.wallet = currentWallet
                self?.presenter.show(walletName: currentWallet?.name)
                completion?()
            },
            failure: presenter.show(error:))
    }
    
    func reloadCategories() {
        guard let walletId = wallet?.id else {
            return
        }
        
        getCategoriesUseCase.getCategories(
            forWalletId: walletId,
            success: { [weak self] categories in
                self?.categories = categories
                self?.presenter.reload(categories: categories)
            },
            failure: presenter.show(error:))
    }
    
    func reloadSubcategories(forCategory category: CategoryModel) {
        guard let categoryId = category.id else {
            return
        }
        
        getSubcategoriesUseCase.getCategories(
            forCategoryId: categoryId,
            success: { [weak self] subcategories in
                self?.subcategories = subcategories
                self?.presenter.reload(subcategories: subcategories)
            },
            failure: presenter.show(error:))
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
