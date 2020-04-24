import Foundation

public class NumberParser {
    let numberFormatterWithComma: NumberFormatter = {
        let nf = NumberFormatter()
        nf.decimalSeparator = ","
        
        return nf
    }()
    
    let numberFormatterWithPoint: NumberFormatter = {
        let nf = NumberFormatter()
        nf.decimalSeparator = "."
        
        return nf
    }()
    
    public init() {}
    
    public func getNumber(fromString string: String) -> NSNumber? {
        let number: NSNumber? = numberFormatterWithComma.number(from: string) ?? numberFormatterWithPoint.number(from: string)
        
        return number
    }
}
