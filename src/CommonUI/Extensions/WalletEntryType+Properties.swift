//
//  WalletEntryType+Properties.swift
//  Domain
//
//  Created by Patryk Mieszała on 07/04/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Common
import Domain

public extension WalletEntryType {
    var textColor: UIColor {
        switch self {
        case .outcome: return Colors.numberRed
        case .income: return Colors.numberGreen
        }
    }
}
