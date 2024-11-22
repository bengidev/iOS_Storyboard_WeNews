//
//  MainCoordinator.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 22/11/24.
//

import Foundation
import RxSwift

class MainCoordinator: BaseCoordinator {
    // MARK: Static Properties

    static let intance: MainCoordinator = .init()

    // MARK: Properties

    private let disposeBag = DisposeBag()

    // MARK: Lifecycle

    override private init() {}

    // MARK: Overridden Functions

    override func start() {
        let viewController = MainViewController.generateTabBarController()
        guard let mainViewController = viewController as? MainViewController else { return }

        self.navigationController.pushViewController(mainViewController, animated: true)
        self.navigationController.setViewControllers([mainViewController], animated: true)
    }

    // MARK: Functions

    func navigateToHomeScreen() {
        self.removeChildCoordinators()

        let coordinator = MainCoordinator.intance
        coordinator.navigationController = self.navigationController
        self.start(coordinator: coordinator)
    }

    func navigateToFavoriteScreen() {
        self.removeChildCoordinators()

        let coordinator = MainCoordinator.intance
        coordinator.navigationController = self.navigationController
        self.start(coordinator: coordinator)
    }
}
