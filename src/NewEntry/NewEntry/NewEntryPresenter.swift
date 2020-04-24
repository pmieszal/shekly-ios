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
        let sections = NewEntryPresenter.getSectionedList(from: categories)
        
        for (index, section) in sections.enumerated() {
            let sectionName = "section-\(index)"
            snapshot.appendSections([sectionName])
            snapshot.appendItems(section, toSection: sectionName)
        }
        
        viewController?.reloadCategories(snapshot: snapshot)
    }
    
    func reload(subcategories: [SubcategoryModel]) {
        var snapshot = NewEntryViewControllerLogic.SubcategorySnapshot()
        let sections = NewEntryPresenter.getSectionedList(from: subcategories)
        
        for (index, section) in sections.enumerated() {
            let sectionName = "section-\(index)"
            snapshot.appendSections([sectionName])
            snapshot.appendItems(section, toSection: sectionName)
        }
        
        viewController?.reloadSubcategories(snapshot: snapshot)
    }
    
    func dismiss() {
        viewController?.dismiss()
    }
}

private extension NewEntryPresenter {
    class func getSectionedList<T>(from list: [T]) -> [[T]] {
        let middleIndexDouble = Double(list.count) / 2
        let middleIndex: Int = Int(middleIndexDouble.rounded(.up))
        
        let section1: [T] = Array(list.prefix(upTo: middleIndex))
        let section2: [T] = Array(list.suffix(from: middleIndex))
        
        return [section1, section2]
    }
}
