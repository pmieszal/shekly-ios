import Domain
import Foundation

class CurrencyFormatter: SheklyCurrencyFormatter {
    let localeProvider: LocaleProvider
    let numberParser: NumberParser
    
    init(localeProvider: LocaleProvider, numberParser: NumberParser) {
        self.localeProvider = localeProvider
        self.numberParser = numberParser
    }
    
    func getCurrencyString(fromString string: String) -> String? {
        guard let number = numberParser.getNumber(fromString: string) else {
            return nil
        }
        
        let nf = NumberFormatter()
        nf.locale = localeProvider.locale
        nf.numberStyle = .currency
        nf.maximumFractionDigits = 2
        nf.minimumFractionDigits = 2
        
        return nf.string(from: number)
    }
    
    func getCurrencyString(fromNumber number: NSNumber) -> String? {
        let nf = NumberFormatter()
        nf.locale = localeProvider.locale
        nf.numberStyle = .currency
        nf.maximumFractionDigits = 2
        nf.minimumFractionDigits = 2
        
        return nf.string(from: number)
    }
    
    func getCurrencyString(fromNumber number: Double) -> String? {
        return getCurrencyString(fromNumber: number as NSNumber)
    }
    
    func getCurrencyString(fromNumber number: Double?) -> String? {
        guard let number = number else {
            return nil
        }
        
        return getCurrencyString(fromNumber: number)
    }
}
