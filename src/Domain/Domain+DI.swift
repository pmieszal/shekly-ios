import Dip

public extension DependencyContainer {
    func configureDomain() -> DependencyContainer {
        unowned let container = self
        
        container.register(factory: DeleteWalletEntryUseCase.init)
        container.register(factory: GetWalletEntriesUseCase.init)
        container.register(factory: GetWalletsUseCase.init)
        container.register(factory: SaveWalletUseCase.init)
        container.register(factory: SetSessionWalletUseCase.init)
        
        return container
    }
}
