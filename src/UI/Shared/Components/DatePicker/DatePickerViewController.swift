//
//  DatePickerViewController.swift
//  UI
//
//  Created by Patryk Mieszała on 12/04/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Domain

class DatePickerViewController: SheklyViewController<DatePickerViewModel> {
    @IBOutlet private weak var ibDatePicker: UIDatePicker!
    @IBOutlet private weak var ibOKButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ibOKButton.addTarget(self, action: #selector(didTapOKButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapOKButton() {
        viewModel.didPick(date: ibDatePicker.date)
        dismiss(animated: true, completion: nil)
    }
}
