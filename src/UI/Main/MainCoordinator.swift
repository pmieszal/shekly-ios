//
//  MainCoordinator.swift
//  UI
//
//  Created by Patryk Mieszała on 03/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Domain
import User

public final class MainCoordinator: RxCoordinator {
    weak var navigationController: UINavigationController!
    
    let window: UIWindow
    let userFactory: UserFactory
    let viewModelFactory: DomainFactory
    
    public init(window: UIWindow, userFactory: UserFactory, viewModelFactory: DomainFactory) {
        self.window = window
        self.userFactory = userFactory
        self.viewModelFactory = viewModelFactory
        
        super.init()
    }
    
    @discardableResult
    override public func start() -> UIViewController? {
        let nvc = SheklyNavigationController()
        nvc.setNavigationBarHidden(true, animated: false)
        
        let tabCoordinator = TabCoordinator(parent: self, userFactory: userFactory, viewModelFactory: viewModelFactory)
        guard let tab = tabCoordinator.start() else {
            fatalError("VC can't be nil")
        }
        
        nvc.setViewControllers([tab], animated: false)
        
        window.rootViewController = nvc
        window.makeKeyAndVisible()
        navigationController = nvc
        
        return nvc
    }
}

private extension MainCoordinator { }
