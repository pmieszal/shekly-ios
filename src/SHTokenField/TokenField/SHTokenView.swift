import UIKit

open class SHTokenView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setTapGesture(target: Any?, action: Selector?) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        
        addGestureRecognizer(tap)
    }
}
