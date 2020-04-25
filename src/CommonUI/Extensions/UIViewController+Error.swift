import UIKit

extension UIViewController {
    @objc open func show(error: Error) {
        DispatchQueue
            .main
            .async { [weak self] in
                let message = error.localizedDescription
                let alert = UIAlertController(
                    title: R.string.localizable.common_error_title(),
                    message: message,
                    preferredStyle: .alert)
                let ok = UIAlertAction(
                    title: R.string.localizable.common_error_ok_action(),
                    style: .default,
                    handler: nil)
                alert.addAction(ok)
                
                self?.present(alert, animated: true, completion: nil)
            }
    }
}
