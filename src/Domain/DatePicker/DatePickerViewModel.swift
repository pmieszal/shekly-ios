//
//  DatePickerViewModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 14/04/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

public class DatePickerViewModel: ViewModel {
    weak var delegate: DatePickerDelegate?
    
    init(delegate: DatePickerDelegate) {
        self.delegate = delegate
    }
    
    public func didPick(date: Date) {
        delegate?.didPick(date: date)
    }
}
