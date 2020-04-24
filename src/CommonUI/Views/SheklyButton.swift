import UIKit

class SheklyButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            clipsToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var rounded: Bool = false {
        didSet {
            guard rounded == true else {
                return
            }
            
            layer.cornerRadius = frame.height / 2
            clipsToBounds = true
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if rounded == true {
            layer.cornerRadius = frame.height / 2
            clipsToBounds = true
        }
    }
}
