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

public final class PlanRouter: Router {
    private weak var viewController: PlanViewController?
    
    init(viewController: PlanViewController) {
        self.viewController = viewController
    }
}

extension PlanRouter {
    func navigate(to category: SheklyCategoryModel) {
        let categoryConfigurator: CategoryConfigurator = container.forceResolve()
        let category = categoryConfigurator.configureCategoryModule(categoryModel: category)
        
        viewController?.navigationController?.pushViewController(category, animated: true)
    }
}
