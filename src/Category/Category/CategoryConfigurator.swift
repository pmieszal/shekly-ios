//
//  CategoryConfigurator.swift
//  UI
//
//  Created by Patryk Mieszała on 15/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Domain
import CleanArchitectureHelpers

public final class CategoryConfigurator: Configurator {
    public func configureCategoryModule(categoryModel: SheklyCategoryModel) -> UIViewController {
        guard let viewController = R.storyboard.category.categoryViewController() else {
            fatalError("VC can't be nil")
        }
        let router = CategoryRouter(viewController: viewController)
        let viewModel = CategoryViewModel(category: categoryModel, currencyFormatter: container.forceResolve())
        viewController.set(viewModel: viewModel)
        viewController.router = router
        
        return viewController
    }
}
