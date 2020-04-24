import Foundation

public final class GetWalletsUseCase {
    let repository: WalletRepository
    let session: SessionRepository
    
    init(repository: WalletRepository,
         session: SessionRepository) {
        self.repository = repository
        self.session = session
    }
}

public extension GetWalletsUseCase {
    func getWallets(success: (([WalletModel]) -> Void)?,
                    failure: ((SheklyError) -> Void)?) {
        let entries = repository.getWallets()
        
        success?(entries)
    }
    
    func getCurrentWallet(success: ((WalletModel?) -> Void)?,
                          failure: (SheklyError) -> Void?) {
        let wallets = repository.getWallets()
        let wallet = wallets
            .first(where: { $0.id == session.selectedWalletId })
            ?? wallets.first
        
        success?(wallet)
    }
}
