//
//  PlanViewModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 14/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import User
import Database
import Shared

public final class PlanViewModel: SheklyViewModel {
    
    public typealias CategorySelectionHandler = (SheklyCategoryModel) -> Void
    
    //MARK: - Public properties
    public private(set) var categories: [SheklyCategoryModel] = []
    
    //MARK: - Internal properties
    let dataController: SheklyDataController
    let tokenFormatter: SheklyTokenFormatter
    let userProvider: UserManaging
    
    let categorySelectionHandler: CategorySelectionHandler
    
    private var selectedWallet: WalletModel? {
        let wallets = dataController.getWallets()
        let selectedWallet = wallets.filter { $0.id == userProvider.selectedWalletId }.first
        
        return selectedWallet ?? wallets.first
    }
    
    //MARK: - Constructor
    init(
        categorySelectionHandler: @escaping CategorySelectionHandler,
        dataController: SheklyDataController,
        tokenFormatter: SheklyTokenFormatter,
        userProvider: UserManaging
        ) {
        self.categorySelectionHandler = categorySelectionHandler
        self.dataController = dataController
        self.tokenFormatter = tokenFormatter
        self.userProvider = userProvider
    }
    
    //MARK: - Public methods
    public override func viewWillAppear() {
        reload()
    }
    
    public func didSelectCategory(at indexPath: IndexPath) {
        categorySelectionHandler(categories[indexPath.row])
    }
}

//MARK: - Internal methods
extension PlanViewModel {

    func reload() {
        guard let wallet = selectedWallet else { return }
        
        let categories: [CategoryModel] = dataController.getCategories(forWallet: wallet)
        
        let models: [SheklyCategoryModel] = categories
            .map { SheklyCategoryModel(category: $0, formatter: tokenFormatter) }
        
        self.categories = models
    }
}
