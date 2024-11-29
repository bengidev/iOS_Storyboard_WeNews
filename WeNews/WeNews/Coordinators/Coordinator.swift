//
//  Coordinator.swift
//  OuRecipes
//
//  Created by ENB Mac Mini M1 on 08/11/24.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var parentCoordinator: Coordinator? { get set }

    func start()
    func willStart(coordinator: Coordinator)
    func finish()
    func willFinish(coordinator: Coordinator)
    func removeChildCoordinators()
}
