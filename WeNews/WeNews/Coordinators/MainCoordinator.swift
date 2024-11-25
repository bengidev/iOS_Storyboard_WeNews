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

    private let mainViewModel: MainViewModel
    private let homeViewModel: HomeViewModel

    // MARK: Lifecycle

    override private init() {
        self.mainViewModel = .init()
        self.homeViewModel = .init(apiSource: .instance)
    }

    // MARK: Overridden Functions

    override func start() {
        self.buildViewModelBindings()

        let viewController = MainViewController.generateTabBarController()
        guard let mainViewController = viewController as? MainViewController else { return }
        mainViewController.mainViewModel = self.mainViewModel
        mainViewController.homeViewModel = self.homeViewModel

        self.navigationController.pushViewController(mainViewController, animated: true)
        self.navigationController.setViewControllers([mainViewController], animated: true)
    }

    // MARK: Functions

    private func buildViewModelBindings() {
        self.mainViewModel.selectedScreen
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
        coordinator.viewModel = self.homeViewModel
        coordinator.navigationController = self.navigationController
        self.start(coordinator: coordinator)
    }

    private func navigateToFavoriteScreen() {
        self.removeChildCoordinators()

        let coordinator = FavoriteCoordinator.intance
        coordinator.navigationController = self.navigationController
        self.start(coordinator: coordinator)
    }
}
