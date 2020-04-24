import CleanArchitectureHelpers
import Common
import Domain
import UIKit

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
    
    open func bind(viewModel: TViewModel) {}
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        if _viewModel == nil {
            _viewModel = factory?()
            factory = nil // Delete factory to prevent memory leaks.
        }
        
        bind(viewModel: viewModel)
        viewModel.viewDidLoad()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillDisappear()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
}
