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

    static let instance: MainCoordinator = .init()

    // MARK: Properties

    private let currentsApiSource = CurrentsAPISource.instance
    private let disposeBag = DisposeBag()

    private let viewModel: MainViewModel
    private let homeViewModel: HomeViewModel

    // MARK: Lifecycle

    override private init() {
        self.viewModel = .init()
        self.homeViewModel = .init(apiSource: self.currentsApiSource)
    }

    // MARK: Overridden Functions

    override func start() {
        self.buildController()
        self.buildViewModelBindings()
    }

    // MARK: Functions

    private func buildController() {
        let viewController = MainViewController.generateTabBarController()
        guard let mainViewController = viewController as? MainViewController else { return }
        mainViewController.mainViewModel = self.viewModel
        mainViewController.homeViewModel = self.homeViewModel

        self.navigationController.pushViewController(mainViewController, animated: true)
        self.navigationController.setViewControllers([mainViewController], animated: true)
    }

    private func buildViewModelBindings() {
        self.viewModel.selectedScreenObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self else { return }

                switch result {
                case .home:
                    self.navigateToHomeScreen()
                case .favorite:
                    self.navigateToFavoriteScreen()
                }
            })
            .disposed(by: self.disposeBag)
    }

    private func navigateToHomeScreen() {
        self.removeChildCoordinators()

        let coordinator = HomeCoordinator.intance
        coordinator.navigationController = self.navigationController
        coordinator.viewModel = self.homeViewModel

        self.willStart(coordinator: coordinator)
    }

    private func navigateToFavoriteScreen() {
        self.removeChildCoordinators()

        let coordinator = FavoriteCoordinator.intance
        coordinator.navigationController = self.navigationController

        self.willStart(coordinator: coordinator)
    }
}
