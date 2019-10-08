//
//  Loger.swift
//  Shared
//
//  Created by Patryk Mieszała on 03/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import RxMVVMC

#if DEBUG
public let log: Loger = LogerFactory().setup(logLevel: .debug).make()
#else
public let log: Loger = LogerFactory().setup(logLevel: .info).make()
#endif

