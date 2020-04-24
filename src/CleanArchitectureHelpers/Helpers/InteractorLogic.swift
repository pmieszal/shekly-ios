@objc
public protocol InteractorLogic: AnyObject {
    @objc optional func viewDidLoad()
    @objc optional func viewDidAppear()
    @objc optional func viewWillAppear()
    @objc optional func viewDidDisappear()
    @objc optional func viewWillDisappear()
}
