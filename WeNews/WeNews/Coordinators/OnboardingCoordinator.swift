//
//  OnboardingCoordinator.swift
//  OuRecipes
//
//  Created by ENB Mac Mini M1 on 08/11/24.
//

import Foundation
import RxSwift

class OnboardingCoordinator: BaseCoordinator {
    // MARK: Static Properties

    static let intance: OnboardingCoordinator = .init()

    // MARK: Properties

    private let disposeBag = DisposeBag()

    // MARK: Lifecycle

    override private init() {}

    // MARK: Overridden Functions

    override func start() {
        let viewController = OnboardingViewController.generateController()
        guard let onboardingViewController = viewController as? OnboardingViewController else { return }

        self.navigationController.setViewControllers([onboardingViewController], animated: true)
    }

    // MARK: Functions

    func navigateToHomeScreen() {
        self.removeChildCoordinators()

        let coordinator = HomeCoordinator.intance
        coordinator.navigationController = self.navigationController
        self.start(coordinator: coordinator)
    }
}
