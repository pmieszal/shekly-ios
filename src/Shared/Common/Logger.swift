//
//  Loger.swift
//  Shared
//
//  Created by Patryk Mieszała on 03/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import SwiftyBeaver

#if DEBUG
public let log: SwiftyBeaver.Type = {
    let log = SwiftyBeaver.self
    let console = ConsoleDestination()
    console.minLevel = .verbose
    log.addDestination(console)
    
    let file = FileDestination()
    file.minLevel = .info
    log.addDestination(file)
    
    return log
}()
#else
public let log: SwiftyBeaver.Type = {
    let log = SwiftyBeaver.self
    
    let file = FileDestination()
    file.minLevel = .info
    log.addDestination(file)
    
    return log
}()
#endif
