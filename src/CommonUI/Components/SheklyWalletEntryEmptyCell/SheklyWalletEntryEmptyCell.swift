import UIKit

public class SheklyWalletEntryEmptyCell: UITableViewCell {
    @IBOutlet private weak var containerView: UIView!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.roundCorners(corners: .allCorners, radius: 6)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.roundCorners(corners: .allCorners, radius: 6)
    }
    
    public override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        containerView.roundCorners(corners: .allCorners, radius: 6)
    }
}
