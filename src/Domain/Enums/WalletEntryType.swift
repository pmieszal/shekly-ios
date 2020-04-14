//
//  WalletEntryType.swift
//  Database
//
//  Created by Patryk Mieszała on 07/04/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

public enum WalletEntryType: Int16 {
    case outcome = 0
    case income
    
    public var textPrefix: String {
        switch self {
        case .outcome: return "-"
        case .income: return "+"
        }
    }
}
