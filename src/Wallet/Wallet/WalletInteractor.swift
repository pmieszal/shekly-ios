import CleanArchitectureHelpers
import Common
import Domain
import User

protocol WalletInteractorLogic: InteractorLogic {
    func monthCollectionViewDidScroll(toDate date: Date)
    func walletCollectionViewDidScroll(toItemAt indexPath: IndexPath)
    func addWallet(named name: String)
    func deleteEntry(atIndexPath indexPath: IndexPath,
                     completion: ((Bool) -> Void)?)
}

protocol WalletDataStore {}

final class WalletInteractor: WalletDataStore {
    // MARK: - Internal properties
    
    var selectedMonthDate: Date?
    var selectedWallet: WalletModel?
    
    // MARK: - Private properties
    
    private var wallets: [WalletModel] = []
    private var entries: [WalletEntryModel] = []
    
    private let getWalletsUseCase: GetWalletsUseCase
    private let getEntriesUseCase: GetWalletEntriesUseCase
    private let saveWalletUseCase: SaveWalletUseCase
    private let deleteWalletEntryUseCase: DeleteWalletEntryUseCase
    private let setSessionWalletUseCase: SetSessionWalletUseCase
    
    private var presenter: WalletPresenterLogic
    private let currencyFormatter: SheklyCurrencyFormatter
    
    // MARK: - Initializers
    
    init(presenter: WalletPresenterLogic,
         getWalletsUseCase: GetWalletsUseCase,
         saveWalletUseCase: SaveWalletUseCase,
         getEntriesUseCase: GetWalletEntriesUseCase,
         deleteWalletEntryUseCase: DeleteWalletEntryUseCase,
         setSessionWalletUseCase: SetSessionWalletUseCase,
         currencyFormatter: SheklyCurrencyFormatter) {
        self.presenter = presenter
        self.getWalletsUseCase = getWalletsUseCase
        self.saveWalletUseCase = saveWalletUseCase
        self.getEntriesUseCase = getEntriesUseCase
        self.deleteWalletEntryUseCase = deleteWalletEntryUseCase
        self.setSessionWalletUseCase = setSessionWalletUseCase
        self.currencyFormatter = currencyFormatter
        
        self.selectedMonthDate = Date()
    }
}

extension WalletInteractor: WalletInteractorLogic {
    func viewWillAppear() {
        reload()
    }
}

extension WalletInteractor {
    func monthCollectionViewDidScroll(toDate date: Date) {
        selectedMonthDate = date
        reloadEntries()
    }
    
    func walletCollectionViewDidScroll(toItemAt indexPath: IndexPath) {
        let wallet = wallets[indexPath.row]
        
        guard wallet.isEmpty == false else {
            return
        }
        
        selectedWallet = wallet
        setSessionWalletUseCase.set(walletId: wallet.id)
        reloadEntries()
    }
    
    func deleteEntry(atIndexPath indexPath: IndexPath,
                     completion: ((Bool) -> Void)?) {
        guard let entry = entries[safe: indexPath.row] else {
            completion?(false)
            return
        }
        
        deleteWalletEntryUseCase.delete(
            entry: entry,
            success: { success in
                self.reload()
                completion?(success)
            },
            failure: presenter.show(error:))
    }
    
    func addWallet(named name: String) {
        let wallet = WalletModel(id: nil, name: name, entries: [])
        
        saveWalletUseCase.save(
            wallet: wallet,
            success: { saved in
                self.selectedWallet = saved
                self.reload()
            },
            failure: presenter.show(error:))
    }
}

private extension WalletInteractor {
    func reload() {
        reloadCurrentWallet {
            self.reloadWallets(completion: self.reloadEntries)
        }
    }
    
    func reloadCurrentWallet(completion: (() -> Void)?) {
        getWalletsUseCase.getCurrentWallet(
            success: { [weak self] currentWallet in
                self?.selectedWallet = currentWallet
                completion?()
            },
            failure: presenter.show(error:))
    }
    
    func reloadWallets(completion: (() -> Void)?) {
        getWalletsUseCase.getWallets(
            success: { wallets in
                let emptyModel = WalletModel(id: nil, name: nil, entries: [])
                let wallets = wallets + [emptyModel]
                self.wallets = wallets + [emptyModel]
                
                self.presenter.reload(wallets: wallets)
                completion?()
            },
            failure: presenter.show(error:))
    }
    
    func reloadEntries() {
        guard let wallet = selectedWallet, let date = selectedMonthDate else {
            return
        }
        
        getEntriesUseCase.getEntries(
            wallet: wallet,
            monthDate: date,
            success: { entries in
                let models = entries.isEmpty ? [WalletEntryModel()] : entries
                self.entries = models
                
                let cells = models.map { WalletEntryCellModel(entry: $0, currencyFormatter: self.currencyFormatter) }
                self.presenter.reload(entries: cells)
            },
            failure: presenter.show(error:))
    }
}
