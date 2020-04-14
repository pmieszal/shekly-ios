//
//  NewEntryPresenter.swift
//  Domain
//
//  Created by Patryk Mieszała on 15/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Common

public protocol NewEntryPresenter: AnyObject {
    func show(walletName: String?)
    func show(date: String?)
    func show(amount: String, color: UIColor)
    func setSaveButton(enabled: Bool)
    func reloadCategories(changeSet1: ChangeSet, changeSet2: ChangeSet)
    func reloadSubcategories(changeSet1: ChangeSet, changeSet2: ChangeSet)
    func dismiss()
}
