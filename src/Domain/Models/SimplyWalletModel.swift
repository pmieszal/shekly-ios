public struct SimplyWalletModel: Equatable, Hashable {
    public let
        id: String?,
        name: String?
    
    public var isEmpty: Bool { id == nil }
    
    public init(id: String?,
                name: String?) {
        self.id = id
        self.name = name
    }
    
    public init(wallet: WalletModel) {
        id = wallet.id
        name = wallet.name
    }
    
    public init?(wallet: WalletModel?) {
        guard let wallet = wallet else {
            return nil
        }
        
        self.init(wallet: wallet)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id ?? NSUUID().uuidString)
    }
}

public func == (lhs: SimplyWalletModel, rhs: SimplyWalletModel) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
