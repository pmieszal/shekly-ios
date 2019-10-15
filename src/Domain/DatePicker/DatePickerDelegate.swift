//
//  DatePickerDelegate.swift
//  Domain
//
//  Created by Patryk Mieszała on 15/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

public protocol DatePickerDelegate: AnyObject {
    func didPick(date: Date)
}
