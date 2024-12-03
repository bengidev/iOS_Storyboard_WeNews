//
//  HomeDetailCoordinator.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 03/12/24.
//

import Foundation
import RxSwift

class HomeDetailCoordinator: BaseCoordinator {
    // MARK: Static Properties

    static let intance: HomeDetailCoordinator = .init()

    // MARK: Properties

    var news: Article?

    private let viewModel: HomeDetailViewModel
    private let disposeBag = DisposeBag()

    // MARK: Lifecycle

    override private init() {
        self.viewModel = .init()
    }

    // MARK: Overridden Functions

    override func start() {
        self.viewModel.resetViewModelObservables()
        self.buildViewModelBindings()

        let viewController = HomeDetailViewController.generateController()
        guard let homeDetailViewController = viewController as? HomeDetailViewController else { return }
        homeDetailViewController.viewModel = self.viewModel
        homeDetailViewController.news = self.news

        self.navigationController.pushViewController(homeDetailViewController, animated: true)
    }

    // MARK: Functions

    private func buildViewModelBindings() {
        self.bindViewDidDisappearObservable()
    }

    private func bindViewDidDisappearObservable() {
        self.viewModel.viewDidDisappearObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self else { return }

                self.parentCoordinator?.willFinish(coordinator: self)
            })
            .disposed(by: self.disposeBag)
    }
}
