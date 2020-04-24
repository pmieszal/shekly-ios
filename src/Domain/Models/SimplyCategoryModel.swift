import SwiftDate

public struct SimplyCategoryModel: Hashable, Equatable {
    public let
        id: String?,
        name: String,
        wallet: SimplyWalletModel?,
        subcategories: [SimplySubcategoryModel]
    
    public init(id: String?,
                name: String,
                wallet: SimplyWalletModel?,
                subcategories: [SimplySubcategoryModel]) {
        self.id = id
        self.name = name
        self.wallet = wallet
        self.subcategories = subcategories
    }
    
    public init(category: CategoryModel) {
        id = category.id
        name = category.name
        wallet = category.wallet
        subcategories = category.subcategories
    }
    
    public init?(category: CategoryModel?) {
        guard let category = category else {
            return nil
        }
        
        self.init(category: category)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

public func == (lhs: SimplyCategoryModel, rhs: SimplyCategoryModel) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
