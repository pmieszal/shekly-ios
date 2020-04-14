//
//  WalletListConfigurator.swift
//  CommonUI
//
//  Created by Patryk Mieszała on 14/04/2020.
//

import CleanArchitectureHelpers
import Domain

public final class WalletListConfigurator: Configurator {
    public func configureWalletListModule(with delegate: WalletListDelegate) -> UIViewController {
        guard let viewController = R.storyboard.walletList.walletListViewController() else {
            fatalError("VC can't be nil")
        }
        
        let viewModel = WalletListViewModel(presenter: viewController, delegate: delegate)
        viewController.set(viewModel: viewModel)
        
        return viewController
    }
}
