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

    private var appCoordinator: AppCoordinator?

    // MARK: Functions

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let baseWindow = UIWindow(frame: UIScreen.main.bounds)
        self.window = baseWindow

        self.appCoordinator = .init(window: baseWindow)
        self.appCoordinator?.start()

        return true
    }
}
