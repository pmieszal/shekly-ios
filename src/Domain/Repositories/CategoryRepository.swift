//
//  CategoryRepository.swift
//  Domain
//
//  Created by Patryk Mieszała on 23/04/2020.
//

import Foundation

public protocol CategoryRepository: AnyObject {
    func getCategories(forWalletId walletId: String) -> [CategoryModel]
}
