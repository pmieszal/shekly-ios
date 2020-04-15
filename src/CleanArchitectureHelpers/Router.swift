//
//  Router.swift
//  UI
//
//  Created by Patryk Mieszała on 14/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Dip

@available(*, deprecated, message: "Delete this")
open class Router: Resolvable {
    private var injectedContainer: DependencyContainer?
    
    public var container: DependencyContainer {
        guard let container = injectedContainer else {
            fatalError("This can't happen")
        }
        
        return container
    }
    
    public init() {}
    
    public func resolveDependencies(_ container: DependencyContainer) {
        self.injectedContainer = container
    }
    
    public func didResolveDependencies() { }
}
