import UIKit

protocol DatePickerPresenterLogic {}

final class DatePickerPresenter {
    // MARK: - Private Properties
    
    private weak var viewController: DatePickerViewControllerLogic?
    
    // MARK: - Initializers
    
    init(viewController: DatePickerViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension DatePickerPresenter: DatePickerPresenterLogic {}
