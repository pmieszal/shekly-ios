import CleanArchitectureHelpers
import Common
import Domain
import UIKit

protocol NewEntryPresenterLogic: PresenterLogic {
    func show(walletName: String?)
    func show(date: String?)
    func show(amount: String, color: UIColor)
    func setSaveButton(enabled: Bool)
    func reload(categories: [CategoryModel])
    func reload(subcategories: [SubcategoryModel])
    func dismiss()
}

final class NewEntryPresenter {
    // MARK: - Private Properties
    
    private weak var viewController: NewEntryViewControllerLogic?
    
    // MARK: - Initializers
    
    init(viewController: NewEntryViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension NewEntryPresenter: NewEntryPresenterLogic {
    var viewControllerLogic: ViewControllerLogic? {
        viewController
    }
    
    func show(walletName: String?) {
        viewController?.show(walletName: walletName)
    }
    
    func show(date: String?) {
        viewController?.show(date: date)
    }
    
    func show(amount: String, color: UIColor) {
        viewController?.show(amount: amount, color: color)
    }
    
    func setSaveButton(enabled: Bool) {
        viewController?.setSaveButton(enabled: enabled)
    }
    
    func reload(categories: [CategoryModel]) {
        var snapshot = NewEntryViewControllerLogic.CategorySnapshot()
        snapshot.appendSections(["categories"])
        snapshot.appendItems(categories)
        
        viewController?.reloadCategories(snapshot: snapshot)
    }
    
    func reload(subcategories: [SubcategoryModel]) {
        var snapshot = NewEntryViewControllerLogic.SubcategorySnapshot()
        snapshot.appendSections(["subcategories"])
        snapshot.appendItems(subcategories)
        
        viewController?.reloadSubcategories(snapshot: snapshot)
    }
    
    func dismiss() {
        viewController?.dismiss()
    }
}
