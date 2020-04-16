//
//  SheklyViewController.swift
//  CommonUI
//
//  Created by Patryk Mieszała on 16/04/2020.
//

import UIKit
import Common
import Domain
import CleanArchitectureHelpers

open class SheklyViewController: UIViewController {
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
//        viewModel.viewDidLoad()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        viewModel.viewWillAppear()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        viewModel.viewWillDisappear()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        viewModel.viewDidAppear()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        viewModel.viewDidDisappear()
    }
    
    override open func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        let presentationStyle = modalPresentationStyle
        let presentingViewController = self.presentingViewController
        
        //Workaround for new iOS 13 modals
        if presentationStyle == .pageSheet {
            presentingViewController?.viewWillAppear(true)
        }
        
        super.dismiss(animated: flag, completion: {
            if presentationStyle == .pageSheet {
                presentingViewController?.viewDidAppear(true)
            }
            completion?()
        })
    }
    
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        viewWillAppear(true)
    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        viewDidAppear(true)
    }
    
    @discardableResult
    public func showAlert(
        input: AlertControllerInput,
        actions: [UIAlertAction],
        completion: (() -> Void)? = nil
        ) -> UIAlertController {
        
        let alert = UIAlertController(title: input.title, message: input.message, preferredStyle: input.style)
        
        actions
            .forEach { (action) in
                alert.addAction(action)
        }
        
        present(alert, animated: true, completion: completion)
        
        return alert
    }
}

public struct AlertControllerInput {
    let
    title: String?,
    message: String?,
    style: UIAlertController.Style
    
    public init(title: String?,
                message: String?,
                style: UIAlertController.Style) {
        self.title = title
        self.message = message
        self.style = style
    }
}

public extension Array where Element == UIAlertAction {
    static func defaultDeleteActions(okHandler: ((UIAlertAction) -> Void)?, cancelHandler: ((UIAlertAction) -> Void)?) -> [Element] {
        
        let ok = UIAlertAction(title: "OK", style: .destructive, handler: okHandler)
        let cancel = UIAlertAction(title: "Anuluj", style: .cancel, handler: cancelHandler)
        
        return [ok, cancel]
    }
}
