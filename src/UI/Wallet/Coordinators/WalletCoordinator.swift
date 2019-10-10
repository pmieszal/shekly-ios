//
//  WalletCoordinator.swift
//  UI
//
//  Created by Patryk Mieszała on 14/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

import Domain
import User

public final class WalletCoordinator: RxCoordinator {
    
    private weak var navigationController: UINavigationController!
    
    private let userFactory: UserFactory
    private let viewModelFactory: DomainFactory
    
    public init(parent: RxCoordinator, userFactory: UserFactory, viewModelFactory: DomainFactory) {
        self.userFactory = userFactory
        self.viewModelFactory = viewModelFactory
        
        super.init(parent: parent)
    }
    
    @discardableResult
    override public func start() -> UIViewController? {
        let nvc = SheklyNavigationController()
        
        guard let wallet = R.storyboard.wallet.walletViewController() else {
            fatalError("VC can't be nil")
        }
        
        wallet
            .set(viewModel: self.viewModelFactory.getWalletViewModel(presenter: wallet, disposeBag: wallet.disposeBag))
        
        nvc.setViewControllers([wallet], animated: false)
        nvc.setNavigationBarHidden(true, animated: false)
        
        self.navigationController = nvc
        
        return nvc
    }
}

private extension WalletCoordinator {
    
}
