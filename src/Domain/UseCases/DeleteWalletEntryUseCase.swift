import Foundation

public final class DeleteWalletEntryUseCase {
    let repository: WalletEntriesRepository
    
    init(repository: WalletEntriesRepository) {
        self.repository = repository
    }
}

public extension DeleteWalletEntryUseCase {
    func delete(entry: WalletEntryModel,
                success: ((Bool) -> Void)?,
                failure: ((SheklyError) -> Void)?) {
        let result = repository.delete(entry: entry)
        
        success?(result)
    }
}
