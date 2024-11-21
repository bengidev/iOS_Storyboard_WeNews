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

    private let disposeBag = DisposeBag()

    // MARK: Lifecycle

    override private init() {}

    // MARK: Overridden Functions

    override func start() {
        let viewController = HomeSearchViewController.generateController()
        guard let homeSearchViewController = viewController as? HomeSearchViewController else { return }

        self.navigationController.pushViewController(homeSearchViewController, animated: true)
    }
}
