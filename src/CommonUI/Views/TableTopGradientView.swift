import UIKit

class TableTopGradientView: GradientMaskView {
    override func setup() {
        let colors: [CGColor] = [UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor]
        let locations: [NSNumber] = [0.0, 0.4, 0.7, 1]
        
        setupGradient(colors: colors, locations: locations)
    }
}
