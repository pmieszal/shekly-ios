import UIKit

class WalletNavigationTitleView: UIView {
    @IBOutlet private weak var button: UIButton!
    
    func set(title: String?) {
        button.setTitle(title, for: .normal)
    }
}
