import Common
import Domain

public extension WalletEntryType {
    var textColor: UIColor {
        switch self {
        case .outcome: return Colors.numberRed
        case .income: return Colors.numberGreen
        }
    }
}
