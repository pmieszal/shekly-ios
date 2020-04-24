import Dip

open class Configurator: Resolvable {
    private var injectedContainer: DependencyContainer?
    
    public var container: DependencyContainer {
        guard let container = injectedContainer else {
            fatalError("This can't happen")
        }
        
        return container
    }
    
    public init() {}
    
    public func resolveDependencies(_ container: DependencyContainer) {
        injectedContainer = container
    }
    
    public func didResolveDependencies() {}
}
