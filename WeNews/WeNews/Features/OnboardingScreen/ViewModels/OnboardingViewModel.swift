//
//  OnboardingViewModel.swift
//  OuRecipes
//
//  Created by ENB Mac Mini M1 on 15/11/24.
//

import Foundation
import RxCocoa
import RxSwift

class OnboardingViewModel {
    // MARK: Static Properties

    static let instance: OnboardingViewModel = .init()

    // MARK: Properties

    let isOnboardingAccessed = BehaviorSubject(value: false)

    private let coordinator = OnboardingCoordinator.intance
    private let disposeBag = DisposeBag()

    // MARK: Lifecycle

    private init() {}

    // MARK: Functions

    func setOnboardingAccess(to value: Bool) {
        self.isOnboardingAccessed.onNext(value)
        UserDefaultSource.instance.setHaveAccessOnboarding(to: value)
    }

    func requestOnboardingAccess() {
        UserDefaultSource
            .instance
            .getHaveAccessOnboarding()
            .observe(on: MainScheduler.instance)
            .subscribe { event in
                if case let .success(result) = event {
                    self.isOnboardingAccessed.onNext(result)
                }
            }
            .disposed(by: self.disposeBag)
    }

    func navigateToMainScreen() {
        self.coordinator.navigateToMainScreen()
    }
}
