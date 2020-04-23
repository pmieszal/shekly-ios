//
//  GetCategoriesUseCase.swift
//  Domain
//
//  Created by Patryk Mieszała on 23/04/2020.
//

import Foundation

public final class GetCategoriesUseCase {
    let repository: CategoryRepository
    
    init(repository: CategoryRepository) {
        self.repository = repository
    }
}

public extension GetCategoriesUseCase {
    func getCategories(forWalletId walletId: String,
                       success: (([CategoryModel]) -> Void)?,
                       failure: ((SheklyError) -> Void)?) {
        let entries = repository.getCategories(forWalletId: walletId)
        
        success?(entries)
    }
}
