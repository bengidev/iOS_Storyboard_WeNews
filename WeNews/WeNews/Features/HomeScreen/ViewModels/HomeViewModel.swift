//
//  HomeViewModel.swift
//  OuRecipes
//
//  Created by ENB Mac Mini M1 on 18/11/24.
//

import Foundation
import RxCocoa
import RxSwift
import SwiftSoup

class HomeViewModel {
    // MARK: Properties

    private(set) var didTapSearchBarObservable = PublishSubject<Void>()
    private(set) var newsObservable = PublishSubject<[Article]>()
    private(set) var didFinishFetchNewsObservable = BehaviorSubject<Bool>(value: false)
    private(set) var didTapNewsObservable = PublishSubject<Article>()
    private(set) var finishChildCoordinatorsObservable = PublishSubject<Void>()

    private let apiSource: NewsAPISource

    private let disposeBag = DisposeBag()

    // MARK: Lifecycle

    init(apiSource: NewsAPISource) {
        self.apiSource = apiSource
    }

    // MARK: Functions

    func resetViewModelObservables() {
        self.didTapSearchBarObservable = PublishSubject<Void>()
        self.newsObservable = PublishSubject<[Article]>()
        self.didFinishFetchNewsObservable = BehaviorSubject<Bool>(value: false)
        self.didTapNewsObservable = PublishSubject<Article>()
        self.finishChildCoordinatorsObservable = PublishSubject<Void>()
    }

    func didTapSearchBar() {
        self.didTapSearchBarObservable.onNext(())
    }

    func didTapCategory(to value: String) {
        self.didFinishFetchNewsObservable.onNext(false)
        self.apiSource.sendGetTopHeadlines(withCategory: value, forPage: 1)
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMapLatest { news -> Observable<[Article]> in
                return .just((news.articles?.filter { $0.author != nil }) ?? [])
            }
            .catchAndReturn([])
            .debug("didTapCategory", trimOutput: true)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self else { return }

                self.newsObservable.onNext(result)
                self.didFinishFetchNewsObservable.onNext(true)
            })
            .disposed(by: self.disposeBag)
    }
    
    func didTapNews(with value: Article) {
        self.didTapNewsObservable.onNext(value)
    }
    
    func finishChildCoordinators() {
        self.finishChildCoordinatorsObservable.onNext(())
    }
}
