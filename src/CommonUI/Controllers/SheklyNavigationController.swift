import Common
import UIKit

public class SheklyNavigationController: UINavigationController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        topViewController?.viewWillAppear(true)
    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        topViewController?.viewDidAppear(true)
    }
}

private extension SheklyNavigationController {
    func setup() {
        navigationBar.tintColor = Colors.brandColor
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: Colors.brandColor,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium),
        ]
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
    }
}
