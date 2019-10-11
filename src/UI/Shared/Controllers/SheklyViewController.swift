//
//  SheklyViewController.swift
//  UI
//
//  Created by Patryk Mieszała on 03/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Shared
import Domain

class SheklyViewController<TViewModel: ViewModel>: UIViewController {
    
    private var factory: (() -> TViewModel)!
    private var _viewModel: TViewModel?
    
    public var viewModel: TViewModel {
        if let viewModel = _viewModel {
            return viewModel
        } else {
            fatalError("ViewModel must not be accessed before view loads.")
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    typealias ViewModel = TViewModel
    
    func set(viewModel: @autoclosure @escaping () -> TViewModel) {
        self.factory = viewModel
    }
    
    func bind(viewModel: ViewModel) { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if _viewModel == nil {
            _viewModel = factory?()
            factory = nil //Delete factory to prevent memory leaks.
        }
        
        bind(viewModel: viewModel)
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillDisappear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
    
    @discardableResult
    func showAlert(
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

struct AlertControllerInput {
    let title: String?
    let message: String?
    let style: UIAlertController.Style
}

extension Array where Element == UIAlertAction {
    
    static func defaultDeleteActions(okHandler: ((UIAlertAction) -> Void)?, cancelHandler: ((UIAlertAction) -> Void)?) -> [Element] {
        
        let ok = UIAlertAction(title: "OK", style: .destructive, handler: okHandler)
        let cancel = UIAlertAction(title: "Anuluj", style: .cancel, handler: cancelHandler)
        
        return [ok, cancel]
    }
}
