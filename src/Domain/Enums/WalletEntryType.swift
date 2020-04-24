import Foundation

public enum WalletEntryType: Int {
    case outcome = 0
    case income
    
    public var textPrefix: String {
        switch self {
        case .outcome: return "-"
        case .income: return "+"
        }
    }
}
