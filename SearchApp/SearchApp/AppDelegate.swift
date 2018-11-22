//
//  AppDelegate.swift
//  SearchApp
//
//  Created by Nagib Azad on 20/11/18.
//  Copyright © 2018 Nagib Bin Azad. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let tintColor =  UIColor(red: (247/255), green: (247/255), blue: (247/255), alpha: 1)//UIColor(red: 242/255, green: 71/255, blue: 63/255, alpha: 1)
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let tabbarController = UITabBarController()
        let searchViewController = SearchViewController.initializeSearchViewController()
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        let historyViewController = HistoryViewController.initializeHistoryViewController()
        let historyNavigationController = UINavigationController(rootViewController: historyViewController)
        historyNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
        let bokmarkViewController = BookmarkViewController.initializeBookmarkViewController()
        let bookmarkNavigationController = UINavigationController(rootViewController: bokmarkViewController)
        bookmarkNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 3)
        tabbarController.setViewControllers([searchViewController,historyNavigationController,bookmarkNavigationController], animated: true)
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()
        customizeAppearance()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    private func customizeAppearance() {
//        window?.tintColor = tintColor
        UISearchBar.appearance().barTintColor = tintColor
//       UINavigationBar.appearance().barTintColor = tintColor
//        UIToolbar.appearance().barTintColor = tintColor
//        UINavigationBar.appearance().tintColor = UIColor.white
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue):UIColor.white]
    }

}

