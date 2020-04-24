import Foundation

public class LocaleProvider {
    public var locale: Locale {
        let preferredLanguages: [String] = Locale.preferredLanguages
        
        for lang in preferredLanguages where lang.count > 2 {
            let locale: Locale = Locale(identifier: lang)
            
            return locale
        }
        
        return Locale.current
    }
}
