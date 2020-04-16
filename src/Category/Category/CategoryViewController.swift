//
//  CategoryViewController.swift
//  UI
//
//  Created by Patryk Mieszała on 26/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Domain
import Common
import CommonUI

class CategoryViewController: GenericSheklyViewController<CategoryViewModel> {
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    var router: CategoryRouter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func bind(viewModel: CategoryViewModel) {
        super.bind(viewModel: viewModel)
        
        categoryLabel.text = viewModel.categoryName
        headerView.alpha = 0
    }
}

extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.feed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellModel = viewModel.feed[safe: indexPath.row] else {
            return UITableViewCell()
        }
        
        switch cellModel {
        case let viewModel as CategoryHeaderCellViewModel:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.categoryHeaderCell,
                                                           for: indexPath) else {
                fatalError("Cell can't be nil")
            }
            cell.viewModel = viewModel
            
            return cell
            
        case let viewModel as CategorySubcategoriesCellViewModel:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.categorySubcategoriesCell,
                                                           for: indexPath) else {
                fatalError("Cell can't be nil")
            }
            cell.setup(with: viewModel)
            
            return cell
            
//        case let model as SheklyWalletEntryModel:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.walletEntryCell,
//                                                           for: indexPath) else {
//                fatalError("Cell can't be nil")
//            }
//            cell.setup(with: model)
//
//            return cell
            
        default:
            assertionFailure("This can't happen")
            return UITableViewCell()
        }
    }
}

extension CategoryViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleCells: [UITableViewCell] = tableView.visibleCells
        
        guard let headerIndex: Int = visibleCells.firstIndex(where: { $0 is CategoryHeaderCell }) else {
            return
        }
        
        let headerCell: UITableViewCell = visibleCells[headerIndex]
        let headerCellPositionFrame: CGRect = view.convert(headerCell.frame, from: tableView)
        let headerCellY: CGFloat = abs(headerCellPositionFrame.origin.y)
        
        let headerHeight: CGFloat = headerView.frame.size.height
        
        let diff: CGFloat = headerCellY - headerHeight
        
        if diff > 0 {
            let alpha: CGFloat = min(diff / 10, 1)
            
            headerView.alpha = alpha
        } else {
            headerView.alpha = 0
        }
    }
}

private extension CategoryViewController {
    
    func setup() {
        tableView.register(R.nib.categoryHeaderCell)
        tableView.register(R.nib.categorySubcategoriesCell)
        //tableView.register(R.nib.walletEntryCell)
        
        tableView.tableFooterView = UIView()
        tableView.contentInset.top = 20
        tableView.contentInset.bottom = 20
        
        tableView.dataSource = self
        tableView.delegate = self
        
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        headerView.layer.shadowRadius = 2
        headerView.layer.shadowOpacity = 0.3
    }
}
