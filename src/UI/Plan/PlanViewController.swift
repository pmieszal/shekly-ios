//
//  PlanViewController.swift
//  UI
//
//  Created by Patryk Mieszała on 14/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Domain
import Shared

class PlanViewController: SheklyViewController<PlanViewModel> {
    @IBOutlet private weak var tableView: UITableView!
    
    var router: PlanRouter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

extension PlanViewController: PlanPresenter {
    func navigate(to category: SheklyCategoryModel) {
        router?.navigate(to: category)
    }
}

extension PlanViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CategoryListCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.categoryListCell, for: indexPath) else {
            fatalError("Cell can't be nil")
        }
        
        let model = viewModel.categories[indexPath.row]
        cell.model = model
        
        return cell
    }
}

extension PlanViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCategory(at: indexPath)
    }
}

private extension PlanViewController {
    func setup() {
        tableView.register(R.nib.categoryListCell)
        tableView.tableFooterView = UIView()
        tableView.contentInset.top = 20
        tableView.contentInset.bottom = 20
        tableView.dataSource = self
        tableView.delegate = self
    }
}
