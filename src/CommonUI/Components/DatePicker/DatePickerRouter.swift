import UIKit

typealias DatePickerRouterType = DatePickerRouterProtocol & DatePickerDataPassing

@objc protocol DatePickerRouterProtocol {}

protocol DatePickerDataPassing {
    var dataStore: DatePickerDataStore { get }
}

final class DatePickerRouter: DatePickerDataPassing {
    // MARK: - Public Properties
    
    weak var viewController: DatePickerViewController?
    var dataStore: DatePickerDataStore
    
    // MARK: - Initializers
    
    init(viewController: DatePickerViewController?, dataStore: DatePickerDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}

extension DatePickerRouter: DatePickerRouterProtocol {}
