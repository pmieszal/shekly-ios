//
//  DBSubcategoryWorker.swift
//  Database
//
//  Created by Patryk Mieszała on 19/04/2020.
//

import Domain

class DBSubcategoryWorker: DBGroup<DBSubcategoryModel> {
    func getSubcategories(forCategory category: CategoryModel) -> [SubcategoryModel] {
        guard let categoryId = category.id else {
            return []
        }
        
        let filter = NSPredicate(format: "%K == %@", [#keyPath(DBCategoryModel.id), categoryId])
        let subcategories = list(filter: filter)
        
        return subcategories.map(SubcategoryModel.init)
    }
}
