import Domain
import Foundation

protocol NewEntryCellModel: Hashable {
    var id: String? { get }
    var name: String { get }
}

extension CategoryModel: NewEntryCellModel {}
extension SubcategoryModel: NewEntryCellModel {}
