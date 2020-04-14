//
//  NewEntryRouter.swift
//  UI
//
//  Created by Patryk Mieszała on 15/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Domain
import CleanArchitectureHelpers
import CommonUI

class NewEntryRouter: Router {
    weak var viewController: NewEntryViewController?
    
    init(viewController: NewEntryViewController) {
        self.viewController = viewController
    }
}

extension NewEntryRouter {
    @objc
    func presentWalletListPopover(sourceButton: UIButton) {
        guard let delegate: WalletListDelegate = viewController?.viewModel else {
            return
        }
        
        let configurator: WalletListConfigurator = container.forceResolve()
        let walletList = configurator.configureWalletListModule(with: delegate)
        
        viewController?.presentAsPopover(vc: walletList, sourceView: sourceButton, preferredContentSize: CGSize(width: 200, height: 300))
    }

    @objc
    func presentDatePickerPopover(sourceButton: UIButton) {
        guard let delegate: DatePickerDelegate = viewController?.viewModel else {
            return
        }
        let configurator: DatePickerConfigurator = container.forceResolve()
        let datePicker = configurator.configureDatePickerModule(with: delegate)
        
        let screenWidth = UIScreen.main.bounds.width
        let preferredContentSize = CGSize(width: screenWidth - 20, height: 270)
        
        viewController?.presentAsPopover(vc: datePicker, sourceView: sourceButton, preferredContentSize: preferredContentSize)
    }
    
    @objc
    func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
