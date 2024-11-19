//
//  AppDelegate.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 19/11/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: Properties

    var window: UIWindow?

    // MARK: Functions

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemOrange

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = viewController

        return true
    }
}
