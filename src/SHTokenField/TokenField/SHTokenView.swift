//
//  SHTokenView.swift
//  SHTokenField
//
//  Created by Patryk Mieszała on 07/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

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
        
        self.addGestureRecognizer(tap)
    }
}
