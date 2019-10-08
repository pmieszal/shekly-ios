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

    @IBOutlet private weak var ibStackView: UIStackView!

    var viewModel: CategorySubcategoriesCellViewModel! {
        didSet {
            self.initialize()
        }
    }
    
    private func initialize() {
        ibStackView
            .arrangedSubviews
            .forEach { (view) in
                ibStackView.removeArrangedSubview(view)
                view.removeFromSuperview()
        }
        
//        for token in viewModel.subcategoriesTokens {
//            let view = R.nib.walletTokenView.firstView(owner: nil)!
//            view.model = token
//            
//            ibStackView.addArrangedSubview(view)
//        }
    }
}
