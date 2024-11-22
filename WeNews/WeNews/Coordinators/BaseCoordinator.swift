//
//  BaseCoordinator.swift
//  OuRecipes
//
//  Created by ENB Mac Mini M1 on 08/11/24.
//

import UIKit

class BaseCoordinator: Coordinator {
    // MARK: Properties

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController = UINavigationController()

    // MARK: Lifecycle

    init() {}

    // MARK: Functions

    /// Implements the concrete start method in related coordinator
    ///
    func start() { fatalError("start method must be implemented") }

    /// Appends child coordinator and set the parent coordinator
    ///
    /// This method usually used in conjunction to show related feature
    ///
    func start(coordinator: Coordinator) {
        self.childCoordinators.append(coordinator)

        coordinator.parentCoordinator = self
        coordinator.start()

        dump(self.parentCoordinator.debugDescription, name: "start parent")
        dump(self.childCoordinators.debugDescription, name: "start coordinators")
    }

    /// Removes all child coordinators from parent
    ///
    /// This methods usually used when switch to another feature
    ///
    func removeChildCoordinators() {
        dump(self.childCoordinators.debugDescription, name: "removeChildCoordinators before")

        for childCoordinator in self.childCoordinators {
            childCoordinator.removeChildCoordinators()
        }

        self.childCoordinators.removeAll()

        dump(self.childCoordinators.debugDescription, name: "removeChildCoordinators after")
    }

    /// Removes latest child coordinator from parent
    ///
    /// This method usually used when interaction with current
    /// child coordinator finish
    ///
    func didFinish(coordinator: Coordinator) {
        if let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) {
            dump(self.childCoordinators.debugDescription, name: "didFinish before")

            self.childCoordinators.remove(at: index)

            dump(self.childCoordinators.debugDescription, name: "didFinish after")
        }
    }
}
