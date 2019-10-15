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
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var subcategoriesLabel: UILabel!
    @IBOutlet private weak var entryLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    
    var model: SheklyCategoryModel! {
        didSet {
            initialize()
        }
    }
    
    private func initialize() {
        categoryLabel.text = model.categoryText
        subcategoriesLabel.text = model.subcategoriesText
        entryLabel.text = model.entriesText
        amountLabel.text = model.amountText
    }

}
