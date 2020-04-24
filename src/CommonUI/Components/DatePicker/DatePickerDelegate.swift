import Foundation

@objc
public protocol DatePickerDelegate: AnyObject {
    func didPick(date: Date)
}
