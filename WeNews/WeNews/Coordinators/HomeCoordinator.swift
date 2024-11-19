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

    private let disposeBag = DisposeBag()

    // MARK: Lifecycle

    override private init() {}

    // MARK: Overridden Functions

    override func start() {
        let viewController = HomeViewController.generateController()
        guard let homeViewController = viewController as? HomeViewController else { return }

        self.navigationController.pushViewController(homeViewController, animated: true)
        self.navigationController.setViewControllers([homeViewController], animated: true)
    }

    // MARK: Functions
}
