//
//  AppDelegate.swift
//  Shekly
//
//  Created by Patryk Mieszała on 03/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import RxMVVMC

import UI
import Shared
import User
import Domain
import Database

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainCoordinator: MainCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        RxMVVMSettings.logEnabled = true
        RxMVVMSettings.logger = { entry in
            if entry.logLevel > .verbose {
                log.debug(entry.value, terminator: entry.terminator, file: entry.file, function: entry.function, line: entry.line)
            } else {
                log.verbose(entry.value, terminator: entry.terminator, file: entry.file, function: entry.function, line: entry.line)
            }
        }
        
        Bootstrap.tabBarItemAppearance()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let userFactory = UserFactory()
        let databaseFactory = DatabaseFactory()
        let sharedFactory = SharedFactory()
        let viewModelFactory = DomainFactory(userFactory: userFactory, databaseFactory: databaseFactory, sharedFactory: sharedFactory)
        
        self.mainCoordinator = MainCoordinator(window: window, userFactory: userFactory, viewModelFactory: viewModelFactory)
        self.mainCoordinator?.start()
        self.window = window
        
        //Temporary hack for database init on fresh install
        if UserDefaults.standard.string(forKey: "App.Version") == nil {
            
            let url = Bundle.main.url(forResource: "ExpensesJSON", withExtension: "shekly")!
            
            let importer = databaseFactory.getSheklyJSONImporter()
            importer
                .importData(fromJSONUrl: url) {
                    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
                    UserDefaults.standard.set(version, forKey: "App.Version")
            }
        }
        
        return true
    }
    
    func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool {
        //Disable 3rd party keyboards
        if extensionPointIdentifier == UIApplication.ExtensionPointIdentifier.keyboard {
            return false
        }
        
        return true
    }
}

