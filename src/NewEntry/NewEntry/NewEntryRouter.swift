//
//  NewEntryRouter.swift
//  Shekly-generated
//
//  Created by Patryk Mieszała on 17/04/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Domain
import CleanArchitectureHelpers
import CommonUI

typealias NewEntryRouterType = NewEntryRouterProtocol & NewEntryDataPassing

@objc protocol NewEntryRouterProtocol {
    func presentWalletListPopover(sourceButton: UIButton)
    func presentDatePickerPopover(sourceButton: UIButton)
    func dismiss()
}

protocol NewEntryDataPassing {
    var dataStore: NewEntryDataStore { get }
}

final class NewEntryRouter: NewEntryDataPassing {
    // MARK: - Public Properties
    weak var viewController: NewEntryViewController?
    var dataStore: NewEntryDataStore
    
    let walletConfigurator: WalletListConfigurator
    let datePickerConfigurator: DatePickerConfiguratorProtocol
    
    // MARK: - Initializers
    init(viewController: NewEntryViewController?,
         dataStore: NewEntryDataStore,
         walletConfigurator: WalletListConfigurator,
         datePickerConfigurator: DatePickerConfiguratorProtocol) {
        self.viewController = viewController
        self.dataStore = dataStore
        self.walletConfigurator = walletConfigurator
        self.datePickerConfigurator = datePickerConfigurator
    }
}

extension NewEntryRouter: NewEntryRouterProtocol {
    func presentWalletListPopover(sourceButton: UIButton) {
        let walletList = walletConfigurator.configureWalletListModule(with: dataStore.walletListDelegate)
        
        viewController?.presentAsPopover(vc: walletList, sourceView: sourceButton, preferredContentSize: CGSize(width: 200, height: 300))
    }

    func presentDatePickerPopover(sourceButton: UIButton) {
        let datePicker = datePickerConfigurator.configureDatePickerModule(with: dataStore.datePickerDelegate)
        
        let screenWidth = UIScreen.main.bounds.width
        let preferredContentSize = CGSize(width: screenWidth - 20, height: 270)
        
        viewController?.presentAsPopover(vc: datePicker, sourceView: sourceButton, preferredContentSize: preferredContentSize)
    }
    
    func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
