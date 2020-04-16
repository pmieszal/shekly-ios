//
//  AppDelegate.swift
//  Shekly
//
//  Created by Patryk Mieszała on 03/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Dip

import Common
import CommonUI
import User
import Domain
import Database
import Main
import Tabs
import NewEntry
import Wallet
import Plan
import Category

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainRouter: MainRouter?
    
    let container = DependencyContainer.configureApp()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        Bootstrap.tabBarItemAppearance()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainConfigurator: MainConfigurator = container.forceResolve()
        mainRouter = mainConfigurator.configureMainModule(with: window)
        self.window = window
        
        //Temporary hack for database init on fresh install
        if UserDefaults.standard.string(forKey: "App.Version") == nil {
            let url = Bundle.main.url(forResource: "ExpensesJSON", withExtension: "shekly")!
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
        //Disable 3rd party keyboards
        if extensionPointIdentifier == UIApplication.ExtensionPointIdentifier.keyboard {
            return false
        }
        
        return true
    }
}

private extension DependencyContainer {
    static func configureApp() -> DependencyContainer {
        let container = DependencyContainer()
            .configureDatabase()
            .configureUser()
            .configureCommon()
            .configureCommonUI()
            .configureMain()
            .configureTabs()
            .configureCategory()
            .configurePlan()
            .configureWallet()
            .configureNewEntry()

        try? container.bootstrap()
        
        return container
    }
}
