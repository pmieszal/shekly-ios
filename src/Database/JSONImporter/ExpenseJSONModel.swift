import Foundation

class ExpenseJSONModel: Codable {
    let amount: Double
    let date: Date
    let category: String
    let subcategory: String
}
