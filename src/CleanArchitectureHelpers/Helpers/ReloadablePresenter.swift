import Common

@available(*, deprecated, message: "Delete this")
public protocol ReloadablePresenter: AnyObject {
    func reload(changeSet: ChangeSet, setData: (() -> Void)?)
}
