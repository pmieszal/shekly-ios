import Dip
import Domain

public extension DependencyContainer {
    func configureCommon() -> DependencyContainer {
        unowned let container = self
        
        container.register(.unique, factory: { Differ() })
        container.register(.shared, factory: { LocaleProvider() })
        container.register(.shared, factory: { NumberParser() })
        container.register(
            .shared,
            factory: {
                CurrencyFormatter(
                    localeProvider: container.forceResolve(),
                    numberParser: container.forceResolve())
            })
            .implements(SheklyCurrencyFormatter.self)
        
        return container
    }
}
