//
//  Resolver+forceResolve.swift
//  Shared
//
//  Created by Patryk Mieszała on 11/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Swinject

public extension Resolver {
    func forceResolve<Service>(_ serviceType: Service.Type) -> Service {
        guard let resolved = resolve(serviceType) else {
            fatalError("Fix your data!")
        }
        
        return resolved
    }
    
    func forceResolve<TService>() -> TService {
        return forceResolve(TService.self)
    }
}
