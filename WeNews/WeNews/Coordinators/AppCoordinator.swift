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

        self.buildNavigationStyle(with: self)
        self.buildUserDefaultSourceBindings()
    }

    // MARK: Functions

    private func buildNavigationStyle(with coordinator: Coordinator) {
        coordinator.navigationController.navigationBar.isHidden = true
        coordinator.navigationController.navigationBar.prefersLargeTitles = false
    }

    private func buildUserDefaultSourceBindings() {
        UserDefaultSource.instance.getAccessOnboardingResult()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] result in
                guard let self else { return }

                if result {
                    self.navigateToMainScreen()
                } else {
                    self.navigateToOnboardingScreen()
                }
            })
            .disposed(by: self.disposeBag)
    }

    private func navigateToOnboardingScreen() {
        let coordinator = OnboardingCoordinator.instance
        coordinator.navigationController = self.navigationController

        self.willStart(coordinator: coordinator)
    }

    private func navigateToMainScreen() {
        let coordinator = MainCoordinator.instance
        coordinator.navigationController = self.navigationController

        self.willStart(coordinator: coordinator)
    }
}
