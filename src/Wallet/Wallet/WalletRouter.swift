//
//  WalletRouter.swift
//  UI
//
//  Created by Patryk Mieszała on 14/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Domain
import User

final class WalletRouter: Router {
    weak var viewController: WalletViewController?
    
    init(viewController: WalletViewController) {
        self.viewController = viewController
    }
}
