//
//  DatePickerViewModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 14/04/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

public protocol DatePickerDelegate: class {
    func didPick(date: Date)
}

public class DatePickerViewModel: SheklyViewModel {
    
    private weak var delegate: DatePickerDelegate?
    
    init(delegate: DatePickerDelegate) {
        self.delegate = delegate
    }
    
    public func didPick(date: Date) {
        delegate?.didPick(date: date)
    }
}
