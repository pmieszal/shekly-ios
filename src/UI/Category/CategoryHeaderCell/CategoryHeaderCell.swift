//
//  CategoryHeaderCell.swift
//  UI
//
//  Created by Patryk Mieszała on 26/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Domain

class CategoryHeaderCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    
    var viewModel: CategoryHeaderCellViewModel! {
        didSet {
            initialize()
        }
    }
    
    private func initialize() {
        nameLabel.text = viewModel.name
        amountLabel.text = viewModel.amountText
    }
}
