//
//  ReloadableViewController.swift
//  UI
//
//  Created by Patryk Mieszała on 04/04/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Common

@available(*, deprecated, message: "Delete this")
public protocol ReloadablePresenter: AnyObject {
    func reload(changeSet: ChangeSet, setData: (() -> ())?)
}