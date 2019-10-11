//
//  SharedAssembly.swift
//  Shared
//
//  Created by Patryk Mieszała on 11/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Swinject

public class SharedAssembly: Assembly {
    public init() { }
    
    public func assemble(container: Container) {
        container.register(LocaleProvider.self, factory: { _ in LocaleProvider() })
        container.register(NumberParser.self, factory: { _ in NumberParser() })
    }
}
