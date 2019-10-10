//
//  PlanViewController.swift
//  UI
//
//  Created by Patryk Mieszała on 14/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

import Domain
import Shared

class PlanViewController: SheklyViewController<PlanViewModel> {

    @IBOutlet private weak var ibTableView: UITableView!
    @IBOutlet private weak var ibGradientView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func bind(viewModel: PlanViewModel) {
        super.bind(viewModel: viewModel)
        
        viewModel
            .categories
            .drive(ibTableView.rx.items) { tableView, row, model in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell: CategoryListCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.categoryListCell, for: indexPath) else {
                    fatalError("Cell can't be nil")
                }
                cell.model = model
                
                return cell
            }
            .disposed(by: disposeBag)
        
        ibTableView
            .rx
            .modelSelected(SheklyCategoryModel.self)
            .asSignal()
            .emit(onNext: { [weak viewModel] (categoryModel: SheklyCategoryModel) in
                viewModel?.didSelect(categoryModel: categoryModel)
            })
            .disposed(by: disposeBag)
    }
}

private extension PlanViewController {
    
    func setup() {
        self.ibTableView.register(R.nib.categoryListCell)
        self.ibTableView.tableFooterView = UIView()
        self.ibTableView.contentInset.top = 20
        self.ibTableView.contentInset.bottom = 20
    }
}
