import Foundation

public protocol SHTokenFieldDelegate: AnyObject {
    func tokenField(tokenField: SHTokenField, shouldAddTokenNamed name: String) -> Bool
    func tokenField(tokenField: SHTokenField, shouldDeleteTokenAtIndex index: Int) -> Bool
    func tokenField(tokenField: SHTokenField, didDeleteTokenAtIndex index: Int)
    func tokenField(tokenField: SHTokenField,
                    decideTokenPolicyForTextFieldAction action: SHTextFieldAction,
                    decisionHandler: (SHTextFieldActionPolicy) -> Void)
    func tokenField(tokenField: SHTokenField, textDidChange text: String?)
    
    func tokenField(tokenField: SHTokenField, didTapOn tokenView: SHTokenView, atIndex index: Int)
    func tokenField(tokenField: SHTokenField, didTapOnSuggestion tokenView: SHTokenView, atIndex index: Int)
}

public extension SHTokenFieldDelegate {
    func tokenField(tokenField: SHTokenField, shouldAddTokenNamed name: String) -> Bool {
        return true
    }
    
    func tokenField(tokenField: SHTokenField, shouldDeleteTokenAtIndex index: Int) -> Bool {
        return true
    }
    
    func tokenField(tokenField: SHTokenField, didDeleteTokenAtIndex index: Int) {}
    
    func tokenField(tokenField: SHTokenField, textDidChange text: String?) {}
    
    func tokenField(tokenField: SHTokenField, didTapOn tokenView: SHTokenView, atIndex index: Int) {}
    
    func tokenField(tokenField: SHTokenField, didTapOnSuggestion tokenView: SHTokenView, atIndex index: Int) {}
}
