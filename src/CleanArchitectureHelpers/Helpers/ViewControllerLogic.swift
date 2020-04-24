import UIKit

public protocol ViewControllerLogic: AnyObject {
    func show(error: Error)
}

public extension UIViewController {
    @objc open func show(error: Error) {
        DispatchQueue
            .main
            .async { [weak self] in
                let message = error.localizedDescription
                let alert = UIAlertController(
                    title: "Error",
                    message: message,
                    preferredStyle: .alert)
                let ok = UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler: nil)
                alert.addAction(ok)
                
                self?.present(alert, animated: true, completion: nil)
            }
    }
}
