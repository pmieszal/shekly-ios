import Dip

public extension DependencyContainer {
    func forceResolve<T>() -> T {
        do {
            return try self.resolve() as T
        } catch {
            log.error(error)
            fatalError()
        }
    }
    
    func forceResolve<T, A>(arguments arg1: A) -> T {
        do {
            return try self.resolve(arguments: arg1) as T
        } catch {
            log.error(error)
            fatalError()
        }
    }
    
    func forceResolve<T, A, B>(arguments arg1: A, _ arg2: B) -> T {
        do {
            return try self.resolve(arguments: arg1, arg2) as T
        } catch {
            log.error(error)
            fatalError()
        }
    }
    
    func forceResolve<T, A, B, C>(arguments arg1: A, _ arg2: B, _ arg3: C) -> T {
        do {
            return try self.resolve(arguments: arg1, arg2, arg3) as T
        } catch {
            log.error(error)
            fatalError()
        }
    }
    
    func forceResolve<T>(tag: DependencyTagConvertible? = nil) -> T {
        do {
            return try self.resolve(tag: tag) as T
        } catch {
            log.error(error)
            fatalError()
        }
    }
}
