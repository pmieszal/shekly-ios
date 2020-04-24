import Domain

public protocol PlanPresenter: AnyObject {
    func navigate(to category: CategoryModel)
}
