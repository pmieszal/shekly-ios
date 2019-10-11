//
//  WalletCoordinator.swift
//  UI
//
//  Created by Patryk Mieszała on 14/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Domain
import User

final class WalletCoordinator: RxCoordinator {
    weak var navigationController: UINavigationController!
    
    let userFactory: UserFactory
    let viewModelFactory: DomainFactory
    
    init(parent: RxCoordinator, userFactory: UserFactory, viewModelFactory: DomainFactory) {
        self.userFactory = userFactory
        self.viewModelFactory = viewModelFactory
        
        super.init(parent: parent)
    }
    
    @discardableResult
    override func start() -> UIViewController? {
        let nvc = SheklyNavigationController()
        
        guard let wallet = R.storyboard.wallet.walletViewController() else {
            fatalError("VC can't be nil")
        }
        
        wallet
            .set(viewModel: self.viewModelFactory.getWalletViewModel(presenter: wallet))
        
        nvc.setViewControllers([wallet], animated: false)
        nvc.setNavigationBarHidden(true, animated: false)
        
        navigationController = nvc
        
        return nvc
    }
}
