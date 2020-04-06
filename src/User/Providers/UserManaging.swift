//
//  UserManaging.swift
//  User
//
//  Created by Patryk Mieszała on 03/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Combine
import Common

public protocol UserManaging: AnyObject {
    var token: String? { get }
    var selectedWalletId: String? { get }
    
    func set(wallet id: String?)
}
