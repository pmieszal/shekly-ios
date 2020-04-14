//
//  DatePickerConfigurator.swift
//  CommonUI
//
//  Created by Patryk Mieszała on 14/04/2020.
//

import CleanArchitectureHelpers
import Domain

public final class DatePickerConfigurator: Configurator {
    public func configureDatePickerModule(with delegate: DatePickerDelegate) -> UIViewController {
        guard let viewController = R.storyboard.datePicker.datePickerViewController() else {
            fatalError("VC can't be nil")
        }
        
        let viewModel = DatePickerViewModel(delegate: delegate)
        viewController.set(viewModel: viewModel)
        
        return viewController
    }
}
