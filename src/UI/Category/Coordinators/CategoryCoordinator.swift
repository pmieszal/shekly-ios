//
//  CategoryCoordinator.swift
//  UI
//
//  Created by Patryk Mieszała on 26/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Domain
import User

public final class CategoryCoordinator: RxCoordinator {
    
    private weak var navigationController: UINavigationController!
    
    private let userFactory: UserFactory
    private let viewModelFactory: DomainFactory
    
    private let categoryModel: SheklyCategoryModel
    
    public init(parent: RxCoordinator, categoryModel: SheklyCategoryModel, navigationController: UINavigationController, userFactory: UserFactory, viewModelFactory: DomainFactory) {
        self.navigationController = navigationController
        self.userFactory = userFactory
        self.viewModelFactory = viewModelFactory
        self.categoryModel = categoryModel
        
        super.init(parent: parent)
    }
    
    @discardableResult
    override public func start() -> UIViewController? {
        guard let category = R.storyboard.category.categoryViewController() else {
            fatalError("VC can't be nil")
        }
        let viewModel: CategoryViewModel = viewModelFactory.getCategoryViewModel(category: self.categoryModel)
        
        category.set(viewModel: viewModel)
        
        navigationController.pushViewController(category, animated: true)
        
        return category
    }
}
