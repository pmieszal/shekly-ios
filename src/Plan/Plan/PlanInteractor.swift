import UIKit

protocol PlanInteractorLogic {}

protocol PlanDataStore {}

final class PlanInteractor: PlanDataStore {
    // MARK: - Public Properties
    var presenter: PlanPresenterLogic
    
    // MARK: - Initializers
    init(presenter: PlanPresenterLogic) {
        self.presenter = presenter
    }
}

extension PlanInteractor: PlanInteractorLogic {}
