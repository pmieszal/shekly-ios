//
//  WalletRouter.swift
//  UI
//
//  Created by Patryk Mieszała on 14/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Domain
import CleanArchitectureHelpers

final class WalletRouter {
    weak var viewController: WalletViewController?
    
    init(viewController: WalletViewController) {
        self.viewController = viewController
    }
}
