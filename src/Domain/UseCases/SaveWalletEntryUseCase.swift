import Foundation

public final class SaveWalletEntryUseCase {
    let repository: WalletEntriesRepository
    
    init(repository: WalletEntriesRepository) {
        self.repository = repository
    }
}

public extension SaveWalletEntryUseCase {
    func save(entry: WalletEntryModel,
              success: (() -> Void)?,
              failure: ((SheklyError) -> Void)?) {
        repository.save(entry: entry)
        
        success?()
    }
}
