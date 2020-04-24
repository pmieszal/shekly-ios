import DynamicColor
import UIKit

class SHTextField: UITextField {
    lazy var height: NSLayoutConstraint = {
        heightAnchor.constraint(equalToConstant: 35)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setup()
    }
    
    // MARK: - Padding
    
    var padding = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
    
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    // MARK: - Setup
    
    func setup() {
        setupInput()
        setupAtts()
    }
    
    func setupInput() {
        borderStyle = .none
        keyboardType = .twitter
        autocapitalizationType = .none
        autocorrectionType = .no
    }
    
    func setupAtts() {
        let textAtts: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .light),
            NSAttributedString.Key.foregroundColor: UIColor(hex: 0x000080),
        ]
        
        defaultTextAttributes = textAtts
        
        let placeholderAtts: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .ultraLight),
            NSAttributedString.Key.foregroundColor: UIColor(hex: 0x19198c),
        ]
        
        let attPlaceholder = NSAttributedString(string: "#shekly", attributes: placeholderAtts)
        
        attributedPlaceholder = attPlaceholder
    }
}
