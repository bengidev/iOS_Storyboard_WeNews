//
//  AppStoryboard.swift
//  OuRecipes
//
//  Created by ENB Mac Mini M1 on 15/11/24.
//

import UIKit

// MARK: - AppStoryboard

protocol AppStoryboard: AnyObject {
    associatedtype ViewController = UIViewController & AppStoryboard
    associatedtype TabBarController = UITabBarController & AppStoryboard
    
    static var id: String { get }
    static var name: String { get }

    static func generateController() -> ViewController?
    static func generateTabBarController() -> TabBarController?
}

extension AppStoryboard {
    static func generateController() -> ViewController? {
        fatalError("generateController method must be implemented")
    }
    
    static func generateTabBarController() -> TabBarController? {
        fatalError("generateTabBarController method must be implemented")
    }
}
