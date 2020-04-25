import Common
import SwiftDate
import UIKit

class WalletMonthCell: UICollectionViewCell {
    @IBOutlet private weak var monthLabel: UILabel!
    
    var date: Date = Date() {
        didSet {
            let style = WalletMonthCell.style(forDate: date)
            monthLabel.text = date.toString(style)
        }
    }
    
    func updateLayout(forCenter center: CGPoint, parentSize: CGSize) {
        let centerX = center.x
        let parentCenterX = parentSize.width / 2
        let diffX = abs(centerX - parentCenterX)
        
        let width = frame.width / 2
        let scale = width / diffX
        let scaleNormalized = max(min(scale, 1), 0.3)
        
        alpha = scaleNormalized
    }
    
    class func style(forDate date: Date) -> DateToStringStyles {
        if date.year == Date().year {
            return DateToStringStyles.custom("MMMM")
        }
        
        return DateToStringStyles.custom("MMMM yyyy")
    }
}
