//
//  SheklyEntryEmptyModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 04/04/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

public class SheklyEntryEmptyModel: SheklyEntryModel {
    
    init() {
        super.init(categoryAndComment: nil, subcategory: nil, amount: nil, amountColor: nil, dateString: nil)
    }
}
