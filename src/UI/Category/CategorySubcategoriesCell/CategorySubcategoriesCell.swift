//
//  CategorySubcategoriesCell.swift
//  UI
//
//  Created by Patryk Mieszała on 02/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Domain

class CategorySubcategoriesCell: UITableViewCell {
    @IBOutlet private weak var stackView: UIStackView!

    var viewModel: CategorySubcategoriesCellViewModel! {
        didSet {
            initialize()
        }
    }
    
    private func initialize() {
        stackView
            .arrangedSubviews
            .forEach { (view) in
                stackView.removeArrangedSubview(view)
                view.removeFromSuperview()
        }
    }
}
