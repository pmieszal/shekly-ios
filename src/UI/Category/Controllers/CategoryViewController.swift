//
//  CategoryViewController.swift
//  UI
//
//  Created by Patryk Mieszała on 26/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

import Domain
import Shared

class CategoryViewController: SheklyViewController<CategoryViewModel>, UIScrollViewDelegate {
    
    @IBOutlet private weak var ibHeaderView: UIView!
    @IBOutlet private weak var ibCategoryLabel: UILabel!
    
    @IBOutlet private weak var ibTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func bind(viewModel: CategoryViewModel) {
        super.bind(viewModel: viewModel)
        
        self.ibCategoryLabel.text = viewModel.categoryName
        self.ibHeaderView.alpha = 0
        
        viewModel
            .feed
            .drive(ibTableView.rx.items) { tableView, row, viewModel in
                let indexPath = IndexPath(row: row, section: 0)
                
                switch viewModel {
                case let viewModel as CategoryHeaderCellViewModel:
                    guard let cell: CategoryHeaderCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.categoryHeaderCell, for: indexPath) else {
                        fatalError("Cell can't be nil")
                    }
                    cell.viewModel = viewModel
                    
                    return cell
                    
                case let viewModel as CategorySubcategoriesCellViewModel:
                    guard let cell: CategorySubcategoriesCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.categorySubcategoriesCell, for: indexPath) else {
                        fatalError("Cell can't be nil")
                    }
                    cell.viewModel = viewModel
                    
                    return cell
                    
                case let model as SheklyEntryModel:
                    guard let cell: WalletEntryCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.walletEntryCell, for: indexPath) else {
                        fatalError("Cell can't be nil")
                    }
                    cell.model = model
                    
                    return cell
                    
                default:
                    fatalError("This can't happen")
                }
            }
            .disposed(by: disposeBag)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleCells: [UITableViewCell] = self.ibTableView.visibleCells
        
        guard let headerIndex: Int = visibleCells.firstIndex(where: { $0 is CategoryHeaderCell }) else {
            return
        }
        
        let headerCell: UITableViewCell = visibleCells[headerIndex]
        let headerCellPositionFrame: CGRect = self.view.convert(headerCell.frame, from: self.ibTableView)
        let headerCellY: CGFloat = abs(headerCellPositionFrame.origin.y)
        
        let headerHeight: CGFloat = self.ibHeaderView.frame.size.height
        
        let diff: CGFloat = headerCellY - headerHeight
        
        if diff > 0 {
            let alpha: CGFloat = min(diff / 10, 1)
            
            self.ibHeaderView.alpha = alpha
        }
        else {
            self.ibHeaderView.alpha = 0
        }
    }
}

private extension CategoryViewController {
    
    func setup() {
        self.ibTableView.register(R.nib.categoryHeaderCell)
        self.ibTableView.register(R.nib.categorySubcategoriesCell)
        self.ibTableView.register(R.nib.walletEntryCell)
        
        self.ibTableView.tableFooterView = UIView()
        self.ibTableView.contentInset.top = 20
        self.ibTableView.contentInset.bottom = 20
        
        self.ibTableView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        self.ibHeaderView.layer.shadowColor = UIColor.black.cgColor
        self.ibHeaderView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.ibHeaderView.layer.shadowRadius = 2
        self.ibHeaderView.layer.shadowOpacity = 0.3
    }
}
