import Foundation

public protocol WalletEntriesRepository: AnyObject {
    func getWalletEntries(forWalletId walletId: String) -> [WalletEntryModel]
    func getWalletEntries(forWalletId walletId: String, monthDate: Date) -> [WalletEntryModel]
    func save(entry: WalletEntryModel)
    func delete(entry: WalletEntryModel) -> Bool
}
