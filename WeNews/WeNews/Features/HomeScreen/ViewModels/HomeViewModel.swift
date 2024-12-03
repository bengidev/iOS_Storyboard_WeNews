//
//  HomeViewModel.swift
//  OuRecipes
//
//  Created by ENB Mac Mini M1 on 18/11/24.
//

import Foundation
import RxCocoa
import RxSwift

class HomeViewModel {
    // MARK: Properties

    private(set) var newsObservable = BehaviorSubject<News>(value: .empty)
    private(set) var didTapSearchBarObservable = PublishSubject<Void>()

    private let apiSource: NewsAPISource

    private let disposeBag = DisposeBag()

    // MARK: Lifecycle

    init(apiSource: NewsAPISource) {
        debugPrint("HomeViewModel init")

        self.apiSource = apiSource
    }

    // MARK: Functions

    func resetViewModelObservables() {
        debugPrint("resetViewModelObservables")

        self.newsObservable = BehaviorSubject<News>(value: .empty)
        self.didTapSearchBarObservable = PublishSubject<Void>()
    }

    func didTapSearchBar() {
        self.didTapSearchBarObservable.onNext(())
    }
}
