import Foundation

public protocol SessionRepository: AnyObject {
    var selectedWalletId: String? { get }
    
    func set(walletId: String?)
}
