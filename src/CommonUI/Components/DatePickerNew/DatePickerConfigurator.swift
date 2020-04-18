//
//  DatePickerConfigurator.swift
//  Shekly-generated
//
//  Created by Patryk Mieszała on 18/04/2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import CleanArchitectureHelpers
import Domain

public protocol DatePickerConfiguratorProtocol {
    func configureDatePickerModule(with delegate: DatePickerDelegate) -> UIViewController
}

class DatePickerConfigurator: Configurator, DatePickerConfiguratorProtocol {
    public func configureDatePickerModule(with delegate: DatePickerDelegate) -> UIViewController {
        guard let viewController = R.storyboard.datePicker.datePickerViewController() else {
            fatalError("VC can't be nil")
        }

        let presenter = DatePickerPresenter(viewController: viewController)
        let interactor = DatePickerInteractor(
            presenter: presenter,
            delegate: delegate)
        let router = DatePickerRouter(
            viewController: viewController,
            dataStore: interactor)

        viewController.interactor = interactor
        viewController.router = router

        return viewController
    }
}
