import Foundation

class WalletJSONModel: Codable {
    let name: String
    let expenses: [ExpenseJSONModel]
}
