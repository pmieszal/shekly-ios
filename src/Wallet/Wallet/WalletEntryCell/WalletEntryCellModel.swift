import Domain
import SwiftDate

final class WalletEntryCellModel: Hashable {
    let entry: WalletEntryModel
    
    let id: String?
    let amountText: String
    let amountColor: UIColor
    let categoryAndComment: String?
    let subcategoryName: String?
    let dateString: String
    let date: Date
    
    init(entry: WalletEntryModel,
         currencyFormatter: SheklyCurrencyFormatter) {
        self.entry = entry
        
        id = entry.id
        amountColor = entry.type.textColor
        amountText = entry
            .type
            .textPrefix
            .appending(" ")
            .appending(currencyFormatter.getCurrencyString(fromNumber: entry.amount) ?? "")
        
        categoryAndComment = entry
            .category?
            .name
            .appending(entry.text.isEmpty ? "" : " - ")
            .appending(entry.text)
        
        subcategoryName = entry.subcategory?.name
        dateString = entry.date.toString(DateToStringStyles.date(DateFormatter.Style.long))
        date = entry.date
    }
    
    func hash(into hasher: inout Hasher) {
        entry.hash(into: &hasher)
    }
    
    public static func == (lhs: WalletEntryCellModel, rhs: WalletEntryCellModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
