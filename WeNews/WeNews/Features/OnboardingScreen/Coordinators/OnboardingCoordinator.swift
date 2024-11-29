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

    static let instance: OnboardingCoordinator = .init()

    // MARK: Properties

    private let disposeBag = DisposeBag()

    private let viewModel: OnboardingViewModel

    // MARK: Lifecycle

    override private init() {
        self.viewModel = .init()
    }

    // MARK: Overridden Functions

    override func start() {
        self.buildController()
        self.buildViewModelBindings()
    }

    override func finish() {
        self.viewModel.disposeAllObservables()
    }

    // MARK: Functions

    private func buildController() {
        let viewController = OnboardingViewController.generateController()
        guard let onboardingViewController = viewController as? OnboardingViewController else { return }
        onboardingViewController.viewModel = self.viewModel

        self.navigationController.setViewControllers([onboardingViewController], animated: true)
    }

    private func buildViewModelBindings() {
        self.viewModel.didTapGetStartedButtonObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self else { return }

                self.navigateToMainScreen()
            })
            .disposed(by: self.disposeBag)
    }

    private func navigateToMainScreen() {
        // Refer parentCoordinator to `AppCoordinator`
        // Remove this coordinator, bacause it's just show only once
        //
        self.parentCoordinator?.willFinish(coordinator: self)

        let coordinator = MainCoordinator.instance
        coordinator.navigationController = self.navigationController

        self.parentCoordinator?.willStart(coordinator: coordinator)
    }
}
