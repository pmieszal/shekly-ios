//
//  GradientView.swift
//  UI
//
//  Created by Patryk Mieszała on 02/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit

class GradientView: UIView {
    @IBInspectable
    var startColor: UIColor = .white
    @IBInspectable
    var endColor: UIColor = .black
    
    @IBInspectable
    var startPoint: CGPoint = CGPoint(x: 0, y: 0)
    @IBInspectable
    var endPoint: CGPoint = CGPoint(x: 0, y: 1)
    
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setup()
    }
    
    func setup() {
        guard let gradientLayer = layer as? CAGradientLayer else {
            return
        }
        
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
    }
}
