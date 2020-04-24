import UIKit

protocol DatePickerInteractorLogic {
    func didPick(date: Date)
}

protocol DatePickerDataStore {}

final class DatePickerInteractor: DatePickerDataStore {
    // MARK: - Public Properties
    
    var presenter: DatePickerPresenterLogic
    weak var delegate: DatePickerDelegate?
    
    // MARK: - Initializers
    
    init(presenter: DatePickerPresenterLogic, delegate: DatePickerDelegate) {
        self.presenter = presenter
        self.delegate = delegate
    }
}

extension DatePickerInteractor: DatePickerInteractorLogic {
    func didPick(date: Date) {
        delegate?.didPick(date: date)
    }
}
