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
    // MARK: Properties

    private(set) var onboardingAccessObservable = PublishSubject<Bool>()
    private(set) var didTapGetStartedButtonObservable = PublishSubject<Void>()

    private let disposeBag = DisposeBag()

    // MARK: Lifecycle

    init() {}

    // MARK: Functions

    func setOnboardingAccess(to value: Bool) {
        self.onboardingAccessObservable.onNext(value)

        UserDefaultSource.instance.setAccessOnboardingResult(to: value)
    }

    func getOnboardingAccessResult() {
        UserDefaultSource.instance.getAccessOnboardingResult()
            .observe(on: MainScheduler.instance)
            .subscribe { event in
                if case let .success(result) = event {
                    self.onboardingAccessObservable.onNext(result)
                }
            }
            .disposed(by: self.disposeBag)
    }

    func navigateToMainScreen() {
        self.didTapGetStartedButtonObservable.onNext(())
    }
    
    func disposeAllObservables() {
        self.onboardingAccessObservable.dispose()
        self.didTapGetStartedButtonObservable.dispose()
    }
}
