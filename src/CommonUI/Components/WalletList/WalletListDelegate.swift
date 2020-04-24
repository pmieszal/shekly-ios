import Domain

public protocol WalletListDelegate: AnyObject {
    func didSelect(wallet: WalletModel)
}
