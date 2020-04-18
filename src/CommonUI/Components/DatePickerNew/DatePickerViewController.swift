//
//  DatePickerViewController.swift
//  Shekly-generated
//
//  Created by Patryk Mieszała on 18/04/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DatePickerViewControllerLogic: AnyObject {}

public final class DatePickerViewController: UIViewController {
    // MARK: - Public Properties
    var interactor: DatePickerInteractorLogic?
    var router: DatePickerRouterType?
    
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var okButton: UIButton!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        okButton.addTarget(self, action: #selector(didTapOKButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapOKButton() {
        interactor?.didPick(date: datePicker.date)
        dismiss(animated: true, completion: nil)
    }
}

extension DatePickerViewController: DatePickerViewControllerLogic {}
