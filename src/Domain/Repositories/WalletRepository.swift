import Foundation

public protocol WalletRepository: AnyObject {
    func getWallets() -> [WalletModel]
    func getWallet(id: String) -> WalletModel?
    func save(wallet: WalletModel) -> WalletModel
}
