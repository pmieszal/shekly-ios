import Common
import UIKit

public class WalletListCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.textColor = Colors.brandColor
    }
}
