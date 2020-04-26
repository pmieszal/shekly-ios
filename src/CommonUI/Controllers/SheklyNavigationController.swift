import Common
import UIKit

public class SheklyNavigationController: UINavigationController {
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        topViewController?.viewWillAppear(true)
    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        topViewController?.viewDidAppear(true)
    }
}

public extension SheklyNavigationController {
    func setupClearNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
    }
    
    func setupBrandColors() {
        navigationBar.tintColor = Colors.brandColor
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: Colors.brandColor,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium),
        ]
    }
}
