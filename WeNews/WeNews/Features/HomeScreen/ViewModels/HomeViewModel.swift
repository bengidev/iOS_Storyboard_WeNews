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

    let currentNews = BehaviorSubject<CurrentNews>(value: .empty)
    let shouldNavigateToSearchScreen = BehaviorSubject<Bool>(value: false)

    private let disposeBag = DisposeBag()

    private let apiSource: CurrentsAPISource

    // MARK: Lifecycle

    init(apiSource: CurrentsAPISource) {
        self.apiSource = apiSource
    }

    // MARK: Functions

    func requestLatestNews() {
        self.apiSource.sendGetLatestNews()
            .observe(on: MainScheduler.instance)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { result in
                self.currentNews.on(.next(result))
            }, onError: { error in
                self.currentNews.on(.error(error))
            })
            .disposed(by: self.disposeBag)
    }

    func requestSearchNews(withKeywords keywords: String) {
        self.apiSource.sendGetSearchNews(withKeywords: keywords)
            .observe(on: MainScheduler.instance)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { result in
                self.currentNews.on(.next(result))
            }, onError: { error in
                self.currentNews.on(.error(error))
            })
            .disposed(by: self.disposeBag)
    }

    func requestSearchNews(withCategory category: CategoryNews) {
        self.apiSource.sendGetSearchNews(withCategory: category)
            .observe(on: MainScheduler.instance)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { result in
                self.currentNews.on(.next(result))
            }, onError: { error in
                self.currentNews.on(.error(error))
            })
            .disposed(by: self.disposeBag)
    }

    func requestSearchNews(withCountry country: RegionNews) {
        self.apiSource.sendGetSearchNews(withCountry: country)
            .observe(on: MainScheduler.instance)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { result in
                self.currentNews.on(.next(result))
            }, onError: { error in
                self.currentNews.on(.error(error))
            })
            .disposed(by: self.disposeBag)
    }

    func setShouldNavigateToSearchScreen(to value: Bool) {
        self.shouldNavigateToSearchScreen.onNext(value)
    }
}
