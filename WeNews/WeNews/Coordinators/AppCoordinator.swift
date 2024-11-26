//
//  AppCoordinator.swift
//  OuRecipes
//
//  Created by ENB Mac Mini M1 on 08/11/24.
//

import RxSwift
import UIKit

class AppCoordinator: BaseCoordinator {
    // MARK: Properties

    private var window: UIWindow

    private let disposeBag = DisposeBag()

    // MARK: Lifecycle

    init(window: UIWindow) {
        self.window = window
    }

    // MARK: Overridden Functions

    override func start() {
        self.window.rootViewController = self.navigationController
        self.window.makeKeyAndVisible()

        let coordinator = OnboardingCoordinator.instance
        coordinator.navigationController = self.navigationController

        self.buildNavigationStyle(with: coordinator)
        self.willStart(coordinator: coordinator)
    }

    override func finish() {}

    // MARK: Functions

    private func buildNavigationStyle(with coordinator: Coordinator) {
        coordinator.navigationController.navigationBar.isHidden = true
        coordinator.navigationController.navigationBar.prefersLargeTitles = false
    }
}
