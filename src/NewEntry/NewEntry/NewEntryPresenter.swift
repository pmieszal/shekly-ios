//
//  NewEntryPresenter.swift
//  Shekly-generated
//
//  Created by Patryk Mieszała on 17/04/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import CleanArchitectureHelpers
import Common
import Domain

protocol NewEntryPresenterLogic: PresenterLogic {
    func show(walletName: String?)
    func show(date: String?)
    func show(amount: String, color: UIColor)
    func setSaveButton(enabled: Bool)
    func reload(categories: [SheklyCategoryModel])
    func reload(subcategories: [SheklySubcategoryModel])
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
    
    func reload(categories: [SheklyCategoryModel]) {
        var snapshot = NewEntryViewControllerLogic.DataSnapshot()
        let sections = NewEntryPresenter.getSectionedList(from: categories)
        
        for (index, section) in sections.enumerated() {
            let sectionName = "section-\(index)"
            snapshot.appendSections([sectionName])
            
            let titles = section.map { $0.categoryText }
            snapshot.appendItems(titles, toSection: sectionName)
        }
    }
    
    func reload(subcategories: [SheklySubcategoryModel]) {
        var snapshot = NewEntryViewControllerLogic.DataSnapshot()
        let sections = NewEntryPresenter.getSectionedList(from: subcategories)
        
        for (index, section) in sections.enumerated() {
            let sectionName = "section-\(index)"
            snapshot.appendSections([sectionName])
            
            let titles = section.map { $0.name }
            snapshot.appendItems(titles, toSection: sectionName)
        }
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
