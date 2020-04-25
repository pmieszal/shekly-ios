import Domain
import UIKit

class WalletEntryCell: UITableViewCell {
    @IBOutlet private weak var entryView: UIView!
    @IBOutlet private weak var subcategoryLabel: UILabel!
    @IBOutlet private weak var categoryAndCommentLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    func setup(with model: WalletEntryCellModel) {
        categoryAndCommentLabel.text = model.categoryAndComment
        subcategoryLabel.text = model.subcategoryName
        amountLabel.text = model.amountText
        amountLabel.textColor = model.amountColor
        dateLabel.text = model.dateString
    }
}

private extension WalletEntryCell {
    func setup() {
        entryView.backgroundColor = .systemBackground
        entryView.layer.cornerRadius = 6
        entryView.layer.shadowColor = UIColor.black.cgColor
        entryView.layer.shadowOpacity = 0.1
        entryView.layer.shadowRadius = 2
        entryView.layer.shadowOffset = .zero
        
        subcategoryLabel.textColor = .label
    }
}
