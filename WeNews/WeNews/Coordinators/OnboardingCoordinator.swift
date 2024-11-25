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

    private let viewModel: OnboardingViewModel

    // MARK: Lifecycle

    override private init() {
        self.viewModel = .init()
    }

    // MARK: Overridden Functions

    override func start() {
        self.buildViewModelBindings()

        let viewController = OnboardingViewController.generateController()
        guard let onboardingViewController = viewController as? OnboardingViewController else { return }
        onboardingViewController.viewModel = self.viewModel

        self.navigationController.setViewControllers([onboardingViewController], animated: true)
    }

    // MARK: Functions

    private func buildViewModelBindings() {
        self.viewModel.shouldNavigateToMainScreen
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self else { return }

                if result {
                    self.navigateToMainScreen()
                }
            })
            .disposed(by: self.disposeBag)
    }

    private func navigateToMainScreen() {
        self.parentCoordinator?.didFinish(coordinator: self)
        self.removeChildCoordinators()

        let coordinator = MainCoordinator.intance
        coordinator.navigationController = self.navigationController
        self.start(coordinator: coordinator)
    }
}
