//
//  AppCoordinator.swift
//  OuRecipes
//
//  Created by ENB Mac Mini M1 on 08/11/24.
//

import RxSwift
import UIKit

class AppCoordinator: BaseCoordinator {
    // MARK: Properties

    private var window: UIWindow

    private let disposeBag = DisposeBag()

    // MARK: Lifecycle

    init(window: UIWindow) {
        self.window = window
    }

    // MARK: Overridden Functions

    override func start() {
        self.navigationController.navigationBar.isHidden = true

        self.window.rootViewController = self.navigationController
        self.window.makeKeyAndVisible()

        UserDefaultSource
            .instance
            .getHaveAccessOnboarding()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { result in
                let coordinator: BaseCoordinator

                // Here you could check if user is signed in and show appropriate screen
                if result {
                    coordinator = HomeCoordinator.intance
                } else {
                    coordinator = OnboardingCoordinator.intance
                }

                coordinator.navigationController = self.navigationController
                self.start(coordinator: coordinator)
            })
            .disposed(by: self.disposeBag)
    }
}
