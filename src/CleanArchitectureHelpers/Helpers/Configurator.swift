import Dip
import UIKit

open class Configurator: Resolvable {
    private var injectedContainer: DependencyContainer?
    
    public var container: DependencyContainer {
        guard let container = injectedContainer else {
            fatalError("This can't happen")
        }
        
        return container
    }
    
    public init() {}
    
    open func configureModule(withDependencies dependencies: [String: Any] = [:]) -> UIViewController {
        return UIViewController()
    }
    
    public func resolveDependencies(_ container: DependencyContainer) {
        injectedContainer = container
    }
    
    public func didResolveDependencies() {}
}
