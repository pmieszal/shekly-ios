//
//  PlanViewModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 14/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import User
import Database
import Common

public final class PlanViewModel: ViewModel {
    public typealias CategorySelectionHandler = (SheklyCategoryModel) -> ()
    
    // MARK: - Public properties
    public private(set) var categories: [SheklyCategoryModel] = []
    
    // MARK: - Internal properties
    let dataController: SheklyDataController
    let tokenFormatter: SheklyTokenFormatter
    let userProvider: UserManaging
    
    weak var presenter: PlanPresenter?
    
    private var selectedWallet: WalletModel? {
        let wallets = dataController.getWallets()
        let selectedWallet = wallets.filter { $0.id == userProvider.selectedWalletId }.first
        
        return selectedWallet ?? wallets.first
    }
    
    // MARK: - Constructor
    init(presenter: PlanPresenter,
         dataController: SheklyDataController,
         tokenFormatter: SheklyTokenFormatter,
         userProvider: UserManaging) {
        self.presenter = presenter
        self.dataController = dataController
        self.tokenFormatter = tokenFormatter
        self.userProvider = userProvider
    }
    
    // MARK: - Public methods
    public func viewWillAppear() {
        reload()
    }
    
    public func didSelectCategory(at indexPath: IndexPath) {
        guard let category = categories[safe: indexPath.row] else {
            return
        }
        
        presenter?.navigate(to: category)
    }
}

// MARK: - Internal methods
extension PlanViewModel {
    func reload() {
        guard let wallet = selectedWallet else {
            return
        }
        
        let categories: [CategoryModel] = dataController.getCategories(forWallet: wallet)
        
        let models: [SheklyCategoryModel] = categories
            .map { SheklyCategoryModel(category: $0, formatter: tokenFormatter) }
        
        self.categories = models
    }
}
