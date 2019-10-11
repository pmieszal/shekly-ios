//
//  CategoryViewController.swift
//  UI
//
//  Created by Patryk Mieszała on 26/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Domain
import Shared

class CategoryViewController: SheklyViewController<CategoryViewModel> {
    @IBOutlet private weak var ibHeaderView: UIView!
    @IBOutlet private weak var ibCategoryLabel: UILabel!
    @IBOutlet private weak var ibTableView: UITableView!

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
        
        ibCategoryLabel.text = viewModel.categoryName
        ibHeaderView.alpha = 0
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
            cell.viewModel = viewModel
            
            return cell
            
        case let model as SheklyEntryModel:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.walletEntryCell,
                                                           for: indexPath) else {
                fatalError("Cell can't be nil")
            }
            cell.model = model
            
            return cell
            
        default:
            fatalError("This can't happen")
        }
    }
}

extension CategoryViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleCells: [UITableViewCell] = ibTableView.visibleCells
        
        guard let headerIndex: Int = visibleCells.firstIndex(where: { $0 is CategoryHeaderCell }) else {
            return
        }
        
        let headerCell: UITableViewCell = visibleCells[headerIndex]
        let headerCellPositionFrame: CGRect = view.convert(headerCell.frame, from: ibTableView)
        let headerCellY: CGFloat = abs(headerCellPositionFrame.origin.y)
        
        let headerHeight: CGFloat = ibHeaderView.frame.size.height
        
        let diff: CGFloat = headerCellY - headerHeight
        
        if diff > 0 {
            let alpha: CGFloat = min(diff / 10, 1)
            
            ibHeaderView.alpha = alpha
        } else {
            ibHeaderView.alpha = 0
        }
    }
}

private extension CategoryViewController {
    
    func setup() {
        ibTableView.register(R.nib.categoryHeaderCell)
        ibTableView.register(R.nib.categorySubcategoriesCell)
        ibTableView.register(R.nib.walletEntryCell)
        
        ibTableView.tableFooterView = UIView()
        ibTableView.contentInset.top = 20
        ibTableView.contentInset.bottom = 20
        
        ibTableView.dataSource = self
        ibTableView.delegate = self
        
        ibHeaderView.layer.shadowColor = UIColor.black.cgColor
        ibHeaderView.layer.shadowOffset = CGSize(width: 0, height: 0)
        ibHeaderView.layer.shadowRadius = 2
        ibHeaderView.layer.shadowOpacity = 0.3
    }
}
