import UIKit

class KeyboardLayoutConstraint: NSLayoutConstraint {
    private var offset: CGFloat = 0
    private var keyboardVisibleHeight: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        offset = constant
        
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(KeyboardLayoutConstraint.keyboardWillShowNotification(_:)),
                name: UIResponder.keyboardWillShowNotification,
                object: nil)
        
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(KeyboardLayoutConstraint.keyboardWillHideNotification(_:)),
                name: UIResponder.keyboardWillHideNotification,
                object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Notification
    
    @objc func keyboardWillShowNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            if let frameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let frame = frameValue.cgRectValue
                
                keyboardVisibleHeight = frame.size.height
            }
            
            updateConstant()
        }
    }
    
    @objc func keyboardWillHideNotification(_ notification: Notification) {
        keyboardVisibleHeight = 0
        updateConstant()
    }
    
    func updateConstant() {
        constant = offset + keyboardVisibleHeight
    }
}
