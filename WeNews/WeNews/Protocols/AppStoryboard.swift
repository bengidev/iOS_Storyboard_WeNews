//
//  AppStoryboard.swift
//  OuRecipes
//
//  Created by ENB Mac Mini M1 on 15/11/24.
//

import UIKit

protocol AppStoryboard {
    static var id: String { get }
    static var name: String { get }
    
    static func generateController() -> (AppStoryboard & UIViewController)?
}
