//
//  BaseCoordinator.swift
//  OuRecipes
//
//  Created by ENB Mac Mini M1 on 08/11/24.
//

import UIKit

class BaseCoordinator: Coordinator {
    // MARK: Properties

    var navigationController = UINavigationController()

    // MARK: Lifecycle

    init() {}

    // MARK: Functions

    /// Initiates controller flow in related coordinator
    ///
    func start() { fatalError("start method must be implemented") }

    /// This method usually used in conjunction to show related feature
    ///
    func willStart(coordinator: Coordinator) {
        coordinator.start()
    }

    /// Ends controller flow in related coordinator
    ///
    func finish() { fatalError("finish method must be implemented") }

    /// This method usually used when interaction with current
    /// child coordinator finish
    ///
    func willFinish(coordinator: Coordinator) {
        coordinator.finish()
    }
}
