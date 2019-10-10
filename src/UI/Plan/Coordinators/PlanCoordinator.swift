//
//  PlanCoordinator.swift
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

public final class PlanCoordinator: RxCoordinator {
    
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
        
        guard let plan = R.storyboard.plan.planViewController() else {
            fatalError("VC can't be nil")
        }
        
        //TODO: get rid of callbacks, user presenter + router
        let planViewModel: PlanViewModel = viewModelFactory
            .getPlanViewModel(categorySelectionHandler: { [weak self] categoryModel in
                self?.goTo(category: categoryModel)
            },
                                    disposeBag: plan.disposeBag)
        
        plan.set(viewModel: planViewModel)
        
        nvc.setViewControllers([plan], animated: false)
        nvc.setNavigationBarHidden(true, animated: false)
        
        self.navigationController = nvc
        
        return nvc
    }
}

private extension PlanCoordinator {
    
    func goTo(category model: SheklyCategoryModel) {
        let coordinator = CategoryCoordinator(parent: self, categoryModel: model, navigationController: self.navigationController, userFactory: userFactory, viewModelFactory: viewModelFactory)
        
        coordinator.start()
    }
}


