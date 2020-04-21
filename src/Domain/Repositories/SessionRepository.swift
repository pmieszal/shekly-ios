//
//  SessionRepository.swift
//  Domain
//
//  Created by Patryk Mieszała on 21/04/2020.
//

import Foundation

public protocol SessionRepository: AnyObject {
    var selectedWalletId: String? { get }
    
    func set(walletId: String?)
}
