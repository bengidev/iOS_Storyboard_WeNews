//
//  AppStoryboard.swift
//  OuRecipes
//
//  Created by ENB Mac Mini M1 on 15/11/24.
//

import UIKit

// MARK: - AppStoryboard

protocol AppStoryboard {
    static var id: String { get }
    static var name: String { get }

    static func generateController() -> (AppStoryboard & UIViewController)?
    static func generateTabBarController() -> (AppStoryboard & UITabBarController)?
}

extension AppStoryboard {
    static func generateTabBarController() -> (AppStoryboard & UITabBarController)? {
        fatalError("generateTabBarController method must be implemented")
    }

    static func generateController() -> (AppStoryboard & UIViewController)? {
        fatalError("generateController method must be implemented")
    }
}
