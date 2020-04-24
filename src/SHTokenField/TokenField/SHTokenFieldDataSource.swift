import Foundation

public protocol SHTokenFieldDataSource: AnyObject {
    func numberOfTokensInTokenField(tokenField: SHTokenField) -> Int
    func tokenField(tokenField: SHTokenField, viewForTokenAtIndex index: Int) -> SHTokenView
    
    func numberOfTokenSuggestions(tokenField: SHTokenField) -> Int
    func tokenField(tokenField: SHTokenField, viewForTokenSuggestionAtIndex index: Int) -> SHTokenView
}

public extension SHTokenFieldDataSource {
    func numberOfTokenSuggestions(tokenField: SHTokenField) -> Int {
        return 0
    }
    
    func tokenField(tokenField: SHTokenField, viewForTokenSuggestionAtIndex index: Int) -> SHTokenView {
        return SHTokenView()
    }
}
