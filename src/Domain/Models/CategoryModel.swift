import SwiftDate

public struct CategoryModel: Hashable, Equatable {
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
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

public func == (lhs: CategoryModel, rhs: CategoryModel) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
