import Dip
import UIKit

import AppRoutes
import CleanArchitectureHelpers
import Common
import CommonUI
import Database
import Domain
import Main
import NewEntry
import Plan
import Tabs
import User
import Wallet

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var mainView: UIViewController?
    
    let container = DependencyContainer.configureApp()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        Bootstrap.tabBarItemAppearance()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainConfigurator: Configurator = container.forceResolve(tag: AppRoutes.main)
        mainView = mainConfigurator.configureModule(withDependencies: [MainDependency.window.rawValue: window])
        self.window = window
        
        // Temporary hack for database init on fresh install
        if UserDefaults.standard.string(forKey: "App.Version") == nil {
            let url = R.file.expensesJson()!
            let importer: SheklyJSONImporter = container.forceResolve()
            
            importer.importData(fromJSONUrl: url) {
                let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
                UserDefaults.standard.set(version, forKey: "App.Version")
            }
        }
        
        return true
    }
    
    func application(_ application: UIApplication,
                     shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool {
        // Disable 3rd party keyboards
        if extensionPointIdentifier == UIApplication.ExtensionPointIdentifier.keyboard {
            return false
        }
        
        return true
    }
}

private extension DependencyContainer {
    static func configureApp() -> DependencyContainer {
        let container = DependencyContainer()
            .configureDomain()
            .configureDatabase()
            .configureUser()
            .configureCommon()
            .configureCommonUI()
            .configureMain()
            .configureTabs()
            .configurePlan()
            .configureWallet()
            .configureNewEntry()
        
        try? container.bootstrap()
        
        return container
    }
}
