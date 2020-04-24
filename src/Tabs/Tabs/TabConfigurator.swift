import CleanArchitectureHelpers
import Common
import CommonUI
import Domain
import NewEntry
import Plan
import Wallet

public class TabConfigurator: Configurator {
    public func configureTabModule() -> UIViewController {
        let tabController = SheklyTabBarController()
        let tabRouter = TabRouter(
            viewController: tabController,
            newEntryConfigurator: container.forceResolve())
        tabController.router = tabRouter
        
        let walletConfigurator: WalletConfiguratorProtocol = container.forceResolve()
        let walletViewController = walletConfigurator.configureWalletModule()
        
        let planConfigurator: PlanConfigurator = container.forceResolve()
        let planViewController = planConfigurator.configurePlanModule()
        
        // TODO: move configuration to configurators
        let stats = SheklyViewController()
        let statsViewModel = SheklyViewModel()
        stats.view.backgroundColor = Colors.brandColor
        stats.tabBarItem.title = "Statystyki"
        stats.tabBarItem.image = CommonUI.R.image.tabBarStatsIcon()?.withRenderingMode(.alwaysOriginal)
        stats.tabBarItem.selectedImage = CommonUI.R.image.tabBarStatsIcon()
        
        let more = SheklyViewController()
        let moreViewModel = SheklyViewModel()
        more.view.backgroundColor = Colors.brandColor
        more.tabBarItem.title = "Więcej"
        more.tabBarItem.image = CommonUI.R.image.tabBarMoreIcon()?.withRenderingMode(.alwaysOriginal)
        more.tabBarItem.selectedImage = CommonUI.R.image.tabBarMoreIcon()
        
        let empty = UIViewController()
        
        tabController.setViewControllers([walletViewController, planViewController, empty, stats, more], animated: false)
        
        return tabController
    }
}
