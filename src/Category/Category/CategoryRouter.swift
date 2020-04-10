//
//  CategoryRouter.swift
//  UI
//
//  Created by Patryk Mieszała on 26/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Domain
import User

final class CategoryRouter: Router {
    weak var viewController: CategoryViewController?
    
    init(viewController: CategoryViewController) {
        self.viewController = viewController
    }
}
