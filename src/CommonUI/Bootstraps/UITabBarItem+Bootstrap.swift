import Common
import UIKit

public extension Bootstrap {
    static func tabBarItemAppearance() {
        let normalAtts: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: .regular),
            NSAttributedString.Key.foregroundColor: Colors.text1Color,
        ]
        
        UITabBarItem.appearance().setTitleTextAttributes(normalAtts, for: .normal)
        
        let highlightedAtts: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: .regular),
            NSAttributedString.Key.foregroundColor: UIColor.white,
        ]
        
        UITabBarItem.appearance().setTitleTextAttributes(highlightedAtts, for: .selected)
    }
}
