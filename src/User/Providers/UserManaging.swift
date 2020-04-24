import Combine
import Common

@available(*, deprecated, message: "delete this")
public protocol UserManaging: AnyObject {
    var token: String? { get }
    var selectedWalletId: String? { get }
    
    func set(walletId: String?)
}
