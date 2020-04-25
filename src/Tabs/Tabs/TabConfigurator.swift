import CleanArchitectureHelpers
import Common
import CommonUI
import Domain
import AppRoutes

class TabConfigurator: Configurator {
    override func configureModule(withDependencies dependencies: [String: Any] = [:]) -> UIViewController {
        let tabController = SheklyTabBarController()
        let tabRouter = TabRouter(
            viewController: tabController,
            newEntryConfigurator: container.forceResolve(tag: AppRoutes.newEntry))
        tabController.router = tabRouter
        
        let walletConfigurator: Configurator = container.forceResolve(tag: AppRoutes.wallet)
        let walletViewController = walletConfigurator.configureModule()
        
        let planConfigurator: Configurator = container.forceResolve(tag: AppRoutes.plan)
        let planViewController = planConfigurator.configureModule()
        
        let stats = SheklyViewController()
        stats.view.backgroundColor = Colors.brandColor
        stats.tabBarItem.title = "Statystyki"
        stats.tabBarItem.image = CommonUI.R.image.tabBarStatsIcon()?.withRenderingMode(.alwaysOriginal)
        stats.tabBarItem.selectedImage = CommonUI.R.image.tabBarStatsIcon()
        
        let more = SheklyViewController()
        more.view.backgroundColor = Colors.brandColor
        more.tabBarItem.title = "Więcej"
        more.tabBarItem.image = CommonUI.R.image.tabBarMoreIcon()?.withRenderingMode(.alwaysOriginal)
        more.tabBarItem.selectedImage = CommonUI.R.image.tabBarMoreIcon()
        
        let empty = UIViewController()
        
        tabController.setViewControllers([walletViewController, planViewController, empty, stats, more], animated: false)
        
        return tabController
    }
}
