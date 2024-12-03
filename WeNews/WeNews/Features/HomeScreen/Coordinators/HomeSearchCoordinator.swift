//
//  HomeSearchCoordinator.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 21/11/24.
//

import Foundation
import RxSwift

class HomeSearchCoordinator: BaseCoordinator {
    // MARK: Static Properties

    static let intance: HomeSearchCoordinator = .init()

    // MARK: Properties

    private let viewModel: HomeSearchViewModel

    private let newsApiSource = NewsAPISource.instance
    private let disposeBag = DisposeBag()

    // MARK: Lifecycle

    override private init() {
        self.viewModel = .init(apiSource: self.newsApiSource)
    }

    // MARK: Overridden Functions

    override func start() {
        self.viewModel.resetViewModelObservables()
        self.buildViewModelBindings()

        let viewController = HomeSearchViewController.generateController()
        guard let homeSearchViewController = viewController as? HomeSearchViewController else { return }
        homeSearchViewController.viewModel = self.viewModel

        self.navigationController.pushViewController(homeSearchViewController, animated: true)
    }

    // MARK: Functions

    private func buildViewModelBindings() {
//        self.bindShouldBackToHomeScreenResult()
    }

    private func bindShouldBackToHomeScreenResult() {
//        self.viewModel.shouldBackToHomeScreen
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { [weak self] result in
//                guard let self else { return }
//
//                if result { self.navigateBackToHomeScreen() }
//            })
//            .disposed(by: self.disposeBag)
    }

    private func navigateBackToHomeScreen() {
//        self.navigationController.popViewController(animated: true)
    }
}
