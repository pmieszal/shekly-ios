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
    
    let walletConfigurator: WalletListConfigurator
    let datePickerConfigurator: DatePickerConfigurator
    
    init(viewController: NewEntryViewController,
         walletConfigurator: WalletListConfigurator,
         datePickerConfigurator: DatePickerConfigurator) {
        self.viewController = viewController
        self.walletConfigurator = walletConfigurator
        self.datePickerConfigurator = datePickerConfigurator
    }
}

extension NewEntryRouter {
    @objc
    func presentWalletListPopover(sourceButton: UIButton) {
        guard let delegate: WalletListDelegate = viewController?.viewModel else {
            return
        }
        
        let walletList = walletConfigurator.configureWalletListModule(with: delegate)
        
        viewController?.presentAsPopover(vc: walletList, sourceView: sourceButton, preferredContentSize: CGSize(width: 200, height: 300))
    }

    @objc
    func presentDatePickerPopover(sourceButton: UIButton) {
        guard let delegate: DatePickerDelegate = viewController?.viewModel else {
            return
        }
        let datePicker = datePickerConfigurator.configureDatePickerModule(with: delegate)
        
        let screenWidth = UIScreen.main.bounds.width
        let preferredContentSize = CGSize(width: screenWidth - 20, height: 270)
        
        viewController?.presentAsPopover(vc: datePicker, sourceView: sourceButton, preferredContentSize: preferredContentSize)
    }
    
    @objc
    func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
