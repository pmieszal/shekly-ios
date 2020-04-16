//
//  DatePickerViewController.swift
//  UI
//
//  Created by Patryk Mieszała on 12/04/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Domain

public class DatePickerViewController: GenericSheklyViewController<DatePickerViewModel> {
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var okButton: UIButton!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        okButton.addTarget(self, action: #selector(didTapOKButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapOKButton() {
        viewModel.didPick(date: datePicker.date)
        dismiss(animated: true, completion: nil)
    }
}
