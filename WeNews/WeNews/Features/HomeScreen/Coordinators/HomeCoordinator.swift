//
//  HomeCoordinator.swift
//  OuRecipes
//
//  Created by ENB Mac Mini M1 on 15/11/24.
//

import Foundation
import RxSwift

// MARK: - HomeCoordinator

class HomeCoordinator: BaseCoordinator {
    // MARK: Static Properties

    static let intance: HomeCoordinator = .init()

    // MARK: Properties

    var viewModel: HomeViewModel?

    private let disposeBag = DisposeBag()
    private let apiSource = NewsAPISource.instance

    // MARK: Lifecycle

    override private init() {}

    // MARK: Overridden Functions

    override func start() {
        self.viewModel?.resetViewModelObservables()
        self.buildViewModelBindings()
    }

    // MARK: Functions

    private func buildViewModelBindings() {
        self.bindDidTapSearchBarObservable()
        self.bindDidTapNewsObservable()
        self.bindFinishChildCoordinatorsObservable()
    }

    private func bindDidTapSearchBarObservable() {
        self.viewModel?.didTapSearchBarObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self else { return }

                dump(result, name: "bindDidTapSearchBarObservable")
                self.navigateToHomeSearchScreen()

            })
            .disposed(by: self.disposeBag)
    }

    private func bindDidTapNewsObservable() {
        self.viewModel?.didTapNewsObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self else { return }

                dump(result, name: "bindDidTapNewsObservable")
                self.navigateToHomeDetailScreen(with: result)

            })
            .disposed(by: self.disposeBag)
    }

    private func navigateToHomeSearchScreen() {
        let coordinator = HomeSearchCoordinator.intance
        coordinator.navigationController = self.navigationController

        self.willStart(coordinator: coordinator)
    }

    private func navigateToHomeDetailScreen(with value: Article) {
        self.navigationController.navigationBar.isHidden = false
        self.navigationController.navigationBar.prefersLargeTitles = false

        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            guard let self else { return }

            let coordinator = HomeDetailCoordinator.intance
            coordinator.navigationController = self.navigationController
            coordinator.news = value

            self.willStart(coordinator: coordinator)
        }
    }

    private func bindFinishChildCoordinatorsObservable() {
        self.viewModel?.finishChildCoordinatorsObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                self.removeChildCoordinators()
            })
            .disposed(by: self.disposeBag)
    }
}
