public struct SimplySubcategoryModel {
    public let
        id: String?,
        name: String,
        wallet: SimplyWalletModel?,
        category: SimplyCategoryModel?
    
    public init(id: String?,
                name: String,
                wallet: SimplyWalletModel?,
                category: SimplyCategoryModel?) {
        self.id = id
        self.name = name
        self.wallet = wallet
        self.category = category
    }
    
    public init(subcategory: SubcategoryModel) {
        id = subcategory.id
        name = subcategory.name
        wallet = subcategory.wallet
        category = subcategory.category
    }
}
