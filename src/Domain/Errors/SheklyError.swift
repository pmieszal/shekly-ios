//
//  SheklyError.swift
//  Domain
//
//  Created by Patryk Mieszała on 21/04/2020.
//

import Foundation

public protocol SheklyError: Error {
    var title: String? { get }
    var message: String { get }
}

public extension SheklyError {
    var title: String? { nil }
    var message: String { localizedDescription }
}
