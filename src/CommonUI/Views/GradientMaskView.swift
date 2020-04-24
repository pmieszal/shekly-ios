import UIKit

class GradientMaskView: UIView {
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setup()
    }
    
    func setup() {
        let colors: [CGColor] = [UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor]
        let locations: [NSNumber] = [0.0, 0.4, 0.7, 1]
        
        setupGradient(colors: colors, locations: locations)
    }
    
    func setupGradient(colors: [CGColor], locations: [NSNumber]) {
        let gradient = CAGradientLayer()
        
        gradient.frame = bounds
        gradient.colors = colors
        gradient.locations = locations
        
        layer.mask = gradient
    }
}
