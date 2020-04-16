//
//  GenericSheklyViewController.swift
//  UI
//
//  Created by Patryk Mieszała on 03/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Common
import Domain
import CleanArchitectureHelpers

open class GenericSheklyViewController<TViewModel: ViewModel>: SheklyViewController {
    private var factory: (() -> TViewModel)!
    private var _viewModel: TViewModel?
    
    public var viewModel: TViewModel {
        if let viewModel = _viewModel {
            return viewModel
        } else {
            fatalError("ViewModel must not be accessed before view loads.")
        }
    }
    
    typealias ViewModel = TViewModel
    
    public func set(viewModel: @autoclosure @escaping () -> TViewModel) {
        self.factory = viewModel
    }
    
    open func bind(viewModel: TViewModel) { }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        if _viewModel == nil {
            _viewModel = factory?()
            factory = nil //Delete factory to prevent memory leaks.
        }
        
        bind(viewModel: viewModel)
        viewModel.viewDidLoad()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillDisappear()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
}
