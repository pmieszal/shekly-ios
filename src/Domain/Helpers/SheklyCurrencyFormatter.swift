import Foundation

public protocol SheklyCurrencyFormatter {
    func getCurrencyString(fromString string: String) -> String?
    func getCurrencyString(fromNumber number: NSNumber) -> String?
    func getCurrencyString(fromNumber number: Double) -> String?
    func getCurrencyString(fromNumber number: Double?) -> String?
}
