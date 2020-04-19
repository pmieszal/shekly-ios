//
//  ExpenseJSONModel.swift
//  Database
//
//  Created by Patryk Mieszała on 02/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

class ExpenseJSONModel: Codable {
    let amount: Double
    let date: Date
    let category: String
    let subcategory: String
}
