//
//  DatePickerPresenter.swift
//  Shekly-generated
//
//  Created by Patryk Mieszała on 18/04/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DatePickerPresenterLogic {}

final class DatePickerPresenter {
    // MARK: - Private Properties
    private weak var viewController: DatePickerViewControllerLogic?

    // MARK: - Initializers
    init(viewController: DatePickerViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension DatePickerPresenter: DatePickerPresenterLogic {}
