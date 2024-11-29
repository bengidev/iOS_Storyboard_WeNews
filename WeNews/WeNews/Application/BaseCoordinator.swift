//
//  BaseCoordinator.swift
//  OuRecipes
//
//  Created by ENB Mac Mini M1 on 08/11/24.
//

import UIKit

class BaseCoordinator: Coordinator {
    // MARK: Properties

    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController = UINavigationController()

    // MARK: Lifecycle

    init() {}

    // MARK: Functions

    /// Initiates controller flow in related coordinator
    ///
    func start() { fatalError("start method must be implemented") }

    /// Adds the coordinator into the parent's child coordinators
    ///
    func willStart(coordinator: any Coordinator) {
        self.childCoordinators.append(coordinator)

        coordinator.parentCoordinator = self
        coordinator.start()

        dump(coordinator.parentCoordinator.debugDescription, name: "willStart parent")
        dump(self.childCoordinators.debugDescription, name: "willStart children")
    }

    /// Ends controller flow in related coordinator
    ///
    func finish() {}

    /// Removes the coordinator when interaction with current
    /// child coordinator finished
    ///
    func willFinish(coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            dump(coordinator.parentCoordinator.debugDescription, name: "willFinish parent")
            dump(type(of: coordinator), name: "willFinish coordinator")

            coordinator.finish()

            self.childCoordinators.remove(at: index)
        }
    }

    /// Removes all child coordinators
    ///
    func removeChildCoordinators() {
        dump(self.parentCoordinator.debugDescription, name: "removeChildCoordinators parent")
        dump(self.childCoordinators.debugDescription, name: "removeChildCoordinators children")

        self.childCoordinators.forEach { self.willFinish(coordinator: $0) }
    }
}
