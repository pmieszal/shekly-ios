import Domain

public class SheklyJSONDataController {
    let walletWorker: DBWalletWorker
    let categoryWorker: DBCategoryWorker
    let subcategoryWorker: DBSubcategoryWorker
    let entryWorker: DBWalletEntryWorker
    
    init(walletWorker: DBWalletWorker,
         categoryWorker: DBCategoryWorker,
         subcategoryWorker: DBSubcategoryWorker,
         entryWorker: DBWalletEntryWorker) {
        self.walletWorker = walletWorker
        self.categoryWorker = categoryWorker
        self.subcategoryWorker = subcategoryWorker
        self.entryWorker = entryWorker
    }
    
    func save(wallet: WalletJSONModel, completionHandler: () -> Void) {
        let entries = wallet.expenses
        
        let walletModelToSave = WalletModel(id: nil, name: wallet.name, entries: [])
        let walletModel = walletWorker.save(wallet: walletModelToSave)
        
        for entry in entries {
            let categoryName: String = entry.category.lowercased()
            let subcategoryName: String = entry.subcategory.lowercased()
            let amount: Double = entry.amount
            let date: Date = entry.date
            
            let categories = categoryWorker.getCategories(forWallet: walletModel)
            
            let categoryOptional = categories.filter { $0.name == categoryName }.first
            let category: CategoryModel
            
            if let categoryFromDatabase = categoryOptional {
                category = categoryFromDatabase
            } else {
                let categoryModel = CategoryModel(
                    id: nil,
                    name: categoryName,
                    wallet: SimplyWalletModel(wallet: walletModel),
                    subcategories: [])
                
                category = categoryWorker.save(category: categoryModel)
            }
            
            let subcategories = subcategoryWorker.getSubcategories(forCategory: category)
            
            let subcategoryOptional = subcategories.filter { $0.name == subcategoryName }.first
            let subcategory: SubcategoryModel
            
            if let subcategoryFromDatabase = subcategoryOptional {
                subcategory = subcategoryFromDatabase
            } else {
                let subcategoryModel = SubcategoryModel(
                    id: nil,
                    name: subcategoryName,
                    wallet: SimplyWalletModel(wallet: walletModel),
                    category: SimplyCategoryModel(category: category))
                
                subcategory = subcategoryWorker.save(subcategory: subcategoryModel)
            }
            
            let entry = WalletEntryModel(
                id: nil,
                type: .outcome,
                text: "",
                date: date,
                amount: amount,
                wallet: SimplyWalletModel(wallet: walletModel),
                category: SimplyCategoryModel(category: category),
                subcategory: SimplySubcategoryModel(subcategory: subcategory))
            
            _ = entryWorker.save(entry: entry)
        }
        
        completionHandler()
    }
}
