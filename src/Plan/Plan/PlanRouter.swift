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

public final class PlanRouter {
    private weak var viewController: PlanViewController?
    
    init(viewController: PlanViewController) {
        self.viewController = viewController
    }
}

extension PlanRouter {
}
