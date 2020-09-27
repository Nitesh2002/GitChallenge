//
//  AppDelegate.swift
//  Code_Challenge
//
//  Created by Nitesh on 27/09/20.
//  Copyright © 2020 Nitesh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        setRootViewController()
        return true
    }
    
    private func setRootViewController(){
        let homeVC = InfoViewController()
        homeVC.view.backgroundColor = .red
        let navC = UINavigationController(rootViewController: homeVC)
        self.window?.rootViewController = navC
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window?.makeKeyAndVisible()
        return true
    }
}

