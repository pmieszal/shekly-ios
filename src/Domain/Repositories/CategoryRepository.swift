import Foundation

public protocol CategoryRepository: AnyObject {
    func getCategories(forWalletId walletId: String) -> [CategoryModel]
}
