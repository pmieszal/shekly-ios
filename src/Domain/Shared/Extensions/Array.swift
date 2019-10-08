//
//  Array.swift
//  Domain
//
//  Created by Patryk Mieszała on 04/04/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return index < count ? self[index] : nil
    }
}
