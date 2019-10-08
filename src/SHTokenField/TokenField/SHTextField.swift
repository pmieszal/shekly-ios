//
//  SHTextfield.swift
//  SHTokenField
//
//  Created by Patryk Mieszała on 03/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import DynamicColor
import RxSwift
import RxCocoa

class SHTextField: UITextField {
    
    lazy var height: NSLayoutConstraint = {
        return self.heightAnchor.constraint(equalToConstant: 35)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        self.setup()
    }
    
    //MARK: - Padding
    var padding = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    //MARK: - Setup
    func setup() {
        self.setupInput()
        self.setupAtts()
    }
    
    func setupInput() {
        self.borderStyle = .none
        self.keyboardType = .twitter
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
    }
    
    func setupAtts() {
        let textAtts: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .light),
            NSAttributedString.Key.foregroundColor: UIColor(hex: 0x000080)
        ]
        
        self.defaultTextAttributes = textAtts
        
        let placeholderAtts: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .ultraLight),
            NSAttributedString.Key.foregroundColor: UIColor(hex: 0x19198c)
        ]
        
        let attPlaceholder = NSAttributedString(string: "#shekly", attributes: placeholderAtts)
        
        self.attributedPlaceholder = attPlaceholder
    }
}
