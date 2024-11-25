//
//  HomeCoordinator.swift
//  OuRecipes
//
//  Created by ENB Mac Mini M1 on 15/11/24.
//

import Foundation
import RxSwift

class HomeCoordinator: BaseCoordinator {
    // MARK: Static Properties

    static let intance: HomeCoordinator = .init()

    // MARK: Properties

    weak var viewModel: HomeViewModel?

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
        self.bindShouldNavigateToSearchScreenResult()
    }

    private func bindShouldNavigateToSearchScreenResult() {
        self.viewModel?.shouldNavigateToSearchScreen
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self else { return }

                if result { self.navigateToHomeSearchScreen() }
            })
            .disposed(by: self.disposeBag)
    }

    private func navigateToHomeSearchScreen() {
        let coordinator = HomeSearchCoordinator.intance
        coordinator.navigationController = self.navigationController
        self.start(coordinator: coordinator)
    }
}
