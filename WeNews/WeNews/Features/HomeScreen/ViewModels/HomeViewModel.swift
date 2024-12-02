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

    private(set) var currentNewsObservable = BehaviorSubject<CurrentNews>(value: .empty)
    private(set) var didTapSearchBarObservable = PublishSubject<Void>()
    private(set) var tapSearchBarNumberObservable = PublishSubject<Void>()

    private let apiSource: CurrentsAPISource

    private let disposeBag = DisposeBag()

    // MARK: Lifecycle

    init(apiSource: CurrentsAPISource) {
        debugPrint("HomeViewModel init")

        self.apiSource = apiSource
    }

    // MARK: Functions

    func resetViewModelObservables() {
        debugPrint("resetViewModelObservables")

        self.currentNewsObservable = BehaviorSubject<CurrentNews>(value: .empty)
        self.didTapSearchBarObservable = PublishSubject<Void>()
        self.tapSearchBarNumberObservable = PublishSubject<Void>()
    }

    func requestLatestNews() {
        self.apiSource.sendGetLatestNews()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { result in
                self.currentNewsObservable.on(.next(result))
            }, onError: { error in
                self.currentNewsObservable.on(.error(error))
            })
            .disposed(by: self.disposeBag)
    }

    func requestSearchNews(withCategory category: CategoryNews) {
        self.apiSource.sendGetSearchNews(withCategory: category)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { result in
                self.currentNewsObservable.on(.next(result))
            }, onError: { error in
                self.currentNewsObservable.on(.error(error))
            })
            .disposed(by: self.disposeBag)
    }

    func requestSearchNews(withCountry country: RegionNews) {
        self.apiSource.sendGetSearchNews(withCountry: country)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { result in
                self.currentNewsObservable.on(.next(result))
            }, onError: { error in
                self.currentNewsObservable.on(.error(error))
            })
            .disposed(by: self.disposeBag)
    }

    func didTapSearchBar() {
        self.didTapSearchBarObservable.onNext(())
    }

    func resetTapSearchBarNumber() {
        self.tapSearchBarNumberObservable.onNext(())
    }
}
