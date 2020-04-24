import Foundation

public final class SetSessionWalletUseCase {
    let session: SessionRepository
    
    init(session: SessionRepository) {
        self.session = session
    }
}

public extension SetSessionWalletUseCase {
    func set(walletId: String?) {
        session.set(walletId: walletId)
    }
}
