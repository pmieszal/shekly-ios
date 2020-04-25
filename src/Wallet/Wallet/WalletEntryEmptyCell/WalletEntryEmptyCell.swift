import UIKit
import CommonUI

class WalletEntryEmptyCell: UITableViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        descriptionLabel.text = CommonUI.R.string.localizable.wallet_empty_entry_cell_text()
        containerView.layer.cornerRadius = 6
    }
}
