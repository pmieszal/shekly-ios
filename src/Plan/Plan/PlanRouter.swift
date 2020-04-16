//
//  PlanRouter.swift
//  UI
//
//  Created by Patryk Mieszała on 14/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Domain
import User
import CleanArchitectureHelpers
import Category

public final class PlanRouter {
    private weak var viewController: PlanViewController?
    
    let categoryConfigurator: CategoryConfigurator
    
    init(viewController: PlanViewController,
         categoryConfigurator: CategoryConfigurator) {
        self.viewController = viewController
        self.categoryConfigurator = categoryConfigurator
    }
}

extension PlanRouter {
    func navigate(to category: SheklyCategoryModel) {
        let category = categoryConfigurator.configureCategoryModule(categoryModel: category)
        
        viewController?.navigationController?.pushViewController(category, animated: true)
    }
}
