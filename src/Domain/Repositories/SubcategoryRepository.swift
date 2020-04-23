//
//  SubcategoryRepository.swift
//  Domain
//
//  Created by Patryk Mieszała on 23/04/2020.
//

import Foundation

public protocol SubcategoryRepository: AnyObject {
    func getSubcategories(forCategoryId categoryId: String) -> [SubcategoryModel]
}
