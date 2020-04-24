@available(*, deprecated, message: "Delete this")
public protocol ViewModel: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func viewDidAppear()
    func viewDidDisappear()
}

public extension ViewModel {
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewWillDisappear() {}
    func viewDidAppear() {}
    func viewDidDisappear() {}
}
