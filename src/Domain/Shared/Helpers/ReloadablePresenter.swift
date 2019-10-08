//
//  ReloadableViewController.swift
//  UI
//
//  Created by Patryk Mieszała on 04/04/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit

public protocol ReloadablePresenter: class {
    func reload(changeSet: ChangeSet)
}
