import Foundation

public protocol SubcategoryRepository: AnyObject {
    func getSubcategories(forCategoryId categoryId: String) -> [SubcategoryModel]
}
