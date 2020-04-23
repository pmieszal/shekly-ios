//
//  GetSubcategoriesUseCase.swift
//  Domain
//
//  Created by Patryk Mieszała on 23/04/2020.
//

import Foundation

public final class GetSubcategoriesUseCase {
    let repository: SubcategoryRepository
    
    init(repository: SubcategoryRepository) {
        self.repository = repository
    }
}

public extension GetSubcategoriesUseCase {
    func getCategories(forCategoryId categoryId: String,
                       success: (([SubcategoryModel]) -> Void)?,
                       failure: ((SheklyError) -> Void)?) {
        let entries = repository.getSubcategories(forCategoryId: categoryId)
        
        success?(entries)
    }
}
