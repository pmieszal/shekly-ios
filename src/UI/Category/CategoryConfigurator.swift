//
//  CategoryConfigurator.swift
//  UI
//
//  Created by Patryk Mieszała on 15/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Domain

final class CategoryConfigurator: Configurator {
    func configureCategoryModule(categoryModel: SheklyCategoryModel) -> UIViewController {
        guard let viewController = R.storyboard.category.categoryViewController() else {
            fatalError("VC can't be nil")
        }
        let router: CategoryRouter = container.forceResolve(arguments: viewController)
        let viewModel: CategoryViewModel = container.forceResolve(arguments: categoryModel)
        viewController.set(viewModel: viewModel)
        viewController.router = router
        
        return viewController
    }
}
