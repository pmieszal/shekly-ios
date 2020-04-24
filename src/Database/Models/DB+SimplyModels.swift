import Domain

extension SimplyWalletModel {
    init(_ wallet: DBWalletModel) {
        self.init(id: wallet.id, name: wallet.name)
    }
    
    init?(_ wallet: DBWalletModel?) {
        guard let wallet = wallet else {
            return nil
        }
        
        self.init(wallet)
    }
}

extension SimplyCategoryModel {
    init(_ category: DBCategoryModel) {
        self.init(
            id: category.id,
            name: category.name,
            wallet: nil, // category.wallet,
            subcategories: []) // category.subcategories)
    }
    
    init?(_ category: DBCategoryModel?) {
        guard let category = category else {
            return nil
        }
        
        self.init(category)
    }
}

extension SimplySubcategoryModel {
    init(_ subcategory: DBSubcategoryModel) {
        self.init(
            id: subcategory.id,
            name: subcategory.name,
            wallet: nil,
            category: nil)
    }
    
    init?(_ subcategory: DBSubcategoryModel?) {
        guard let subcategory = subcategory else {
            return nil
        }
        
        self.init(subcategory)
    }
}
