//
//  SheklyEntryModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 04/04/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

public class SheklyEntryModel: Hashable {
    public var hashValue: Int {
        return NSUUID().uuidString.hashValue
    }
    public let categoryAndComment: String?
    public let subcategory: String?
    public let amount: String?
    public let amountColor: UIColor?
    public let dateString: String?
    
    init(categoryAndComment: String?, subcategory: String?, amount: String?, amountColor: UIColor?, dateString: String?) {
        self.categoryAndComment = categoryAndComment
        self.subcategory = subcategory
        self.amount = amount
        self.amountColor = amountColor
        self.dateString = dateString
    }
}

public func ==<T: SheklyEntryModel>(lhs: T, rhs: T) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
