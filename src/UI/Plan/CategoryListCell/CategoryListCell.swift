//
//  CategoryCell.swift
//  UI
//
//  Created by Patryk Mieszała on 14/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Domain

class CategoryListCell: UITableViewCell {
    @IBOutlet private weak var ibCategoryLabel: UILabel!
    @IBOutlet private weak var ibSubcategoriesLabel: UILabel!
    @IBOutlet private weak var ibEntryLabel: UILabel!
    @IBOutlet private weak var ibAmountLabel: UILabel!
    
    var model: SheklyCategoryModel! {
        didSet {
            initialize()
        }
    }
    
    private func initialize() {
        ibCategoryLabel.text = model.categoryText
        ibSubcategoriesLabel.text = model.subcategoriesText
        ibEntryLabel.text = model.entriesText
        ibAmountLabel.text = model.amountText
    }

}
