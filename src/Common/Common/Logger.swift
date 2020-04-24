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
