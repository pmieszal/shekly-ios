import Dip
import Domain

public extension DependencyContainer {
    func configureUser() -> DependencyContainer {
        unowned let container = self
        
        container.register(.singleton, factory: UserProvider.init)
            .implements(SessionRepository.self)
        
        return container
    }
}
