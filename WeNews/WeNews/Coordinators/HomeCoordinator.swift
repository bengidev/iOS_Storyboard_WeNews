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

    private var tapSearchBarNumber = 0

    private let disposeBag = DisposeBag()
    private let apiSource = CurrentsAPISource.instance

    // MARK: Lifecycle

    override private init() {}

    // MARK: Overridden Functions

    override func start() {
        self.buildViewModelBindings()
    }

    // MARK: Functions

    private func buildViewModelBindings() {
        self.bindDidTapSearchBarObservable()
        self.bindTapSearchBarNumberObservable()
    }

    private func bindDidTapSearchBarObservable() {
        self.viewModel?.didTapSearchBarObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }

                self.tapSearchBarNumber += 1
                self.navigateToHomeSearchScreen()

            })
            .disposed(by: self.disposeBag)
    }

    private func navigateToHomeSearchScreen() {
        if self.tapSearchBarNumber <= 1 {
            self.removeChildCoordinators()

            let coordinator = HomeSearchCoordinator.intance
            coordinator.navigationController = self.navigationController

            self.willStart(coordinator: coordinator)
        }
    }

    private func bindTapSearchBarNumberObservable() {
        self.viewModel?.tapSearchBarNumberObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self else { return }

                self.tapSearchBarNumber = 0
            })
            .disposed(by: self.disposeBag)
    }
}
