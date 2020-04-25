import CleanArchitectureHelpers
import Domain
import UIKit

class NewEntryConfigurator: Configurator {
    override func configureModule(withDependencies dependencies: [String: Any] = [:]) -> UIViewController {
        guard let viewController = R.storyboard.newEntry.newEntryViewController() else {
            fatalError("VC can't be nil")
        }
        
        let presenter = NewEntryPresenter(viewController: viewController)
        let interactor = NewEntryInteractor(
            presenter: presenter,
            currencyFormatter: container.forceResolve(),
            numberParser: container.forceResolve(),
            getWalletsUseCase: container.forceResolve(),
            saveEntryUseCase: container.forceResolve(),
            getCategoriesUseCase: container.forceResolve(),
            getSubcategoriesUseCase: container.forceResolve())
        let router = NewEntryRouter(
            viewController: viewController,
            dataStore: interactor,
            walletConfigurator: container.forceResolve(),
            datePickerConfigurator: container.forceResolve())
        
        viewController.interactor = interactor
        viewController.router = router
        
        return viewController
    }
}
