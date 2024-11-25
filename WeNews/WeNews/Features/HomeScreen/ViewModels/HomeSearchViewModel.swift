//
//  HomeSearchViewModel.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 25/11/24.
//

import Foundation
import RxCocoa
import RxSwift

class HomeSearchViewModel {
    // MARK: Properties

    let shouldBackToHomeScreen = PublishSubject<Bool>()

    private let disposeBag = DisposeBag()

    // MARK: Lifecycle

    init() {}

    // MARK: Functions

    func setShouldBackToHomeScreen(to value: Bool) {
        self.shouldBackToHomeScreen.onNext(value)
    }
}
