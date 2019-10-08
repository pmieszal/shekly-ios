//
//  WalletJSONModel.swift
//  Database
//
//  Created by Patryk Mieszała on 23/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

class WalletJSONModel: Codable {
    
    let name: String
    let expenses: [ExpenseJSONModel]
    
}
