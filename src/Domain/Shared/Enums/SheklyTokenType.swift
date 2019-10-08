//
//  SheklyTokenType.swift
//  Domain
//
//  Created by Patryk Mieszała on 04/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Shared

public enum SheklyTokenType: String {
    
    case hash = "#"
    case at = "@"
    case comment = "shekly_comment"
    case number = "shekly_number"
    
    init(token: String, formatter: SheklyTokenFormatter) {
        if token.first == "#" {
            self = .hash
        }
        else if token.first == "@" {
            self = .at
        }
        else if formatter.getNumber(fromToken: token) != nil {
            self = .number
        }
        else {
            self = .comment
        }
    }
    
    public var color: UIColor {
        switch self {
        case .hash: return Colors.categoryColor
        case .at: return Colors.subcategoryColor
        case .comment: return Colors.commentColor
        case .number: return Colors.numberColor
        }
    }
}
