import UIKit

typealias PlanRouterType = PlanRouterProtocol & PlanDataPassing

@objc protocol PlanRouterProtocol {}

protocol PlanDataPassing {
    var dataStore: PlanDataStore { get }
}

final class PlanRouter: PlanDataPassing {
    // MARK: - Public Properties
    
    weak var viewController: PlanViewController?
    var dataStore: PlanDataStore
    
    // MARK: - Initializers
    
    init(viewController: PlanViewController?, dataStore: PlanDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}

extension PlanRouter: PlanRouterProtocol {}
