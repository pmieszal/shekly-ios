//
//  Configurator.swift
//  UI
//
//  Created by Patryk Mieszała on 15/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Dip

public class Configurator: Resolvable {
    
    private var injectedContainer: DependencyContainer?
    
    var container: DependencyContainer {
        guard let container = injectedContainer else {
            fatalError("This can't happen")
        }
        
        return container
    }
    
    public func resolveDependencies(_ container: DependencyContainer) {
        self.injectedContainer = container
    }
    
    public func didResolveDependencies() { }
}