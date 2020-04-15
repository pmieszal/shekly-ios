//
//  PlanViewModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 14/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import User
import Common
import Domain
import CleanArchitectureHelpers

public final class PlanViewModel: ViewModel {
    public typealias CategorySelectionHandler = (SheklyCategoryModel) -> ()
    
    // MARK: - Public properties
    public private(set) var categories: [SheklyCategoryModel] = []
    
    // MARK: - Internal properties
    //let dataController: SheklyDataController
    let userProvider: UserManaging
    
    weak var presenter: PlanPresenter?
    
    private var selectedWallet: SheklyWalletModel? {
        let wallets = [SheklyWalletModel]()// dataController.getWallets()
        let selectedWallet = wallets.filter { $0.id == userProvider.selectedWalletId }.first
        
        return selectedWallet ?? wallets.first
    }
    
    // MARK: - Constructor
    init(presenter: PlanPresenter,
         //dataController: SheklyDataController,
         userProvider: UserManaging) {
        self.presenter = presenter
        //self.dataController = dataController
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
        
        let categories: [SheklyCategoryModel] = []
        //TODO: this
        
        self.categories = categories
    }
}
