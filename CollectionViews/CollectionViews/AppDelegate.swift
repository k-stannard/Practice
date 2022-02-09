//
//  AppDelegate.swift
//  CollectionViews
//
//  Created by Koty Stannard on 2/7/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        let navigationController = UINavigationController()
        navigationController.pushViewController(ViewController(), animated: true)
        
        window?.rootViewController = navigationController
        
        return true
    }
}

