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

    private(set) var searchBarTextObservable = BehaviorSubject<String>(value: "")
    private(set) var searchNewsObservable = PublishSubject<[Article]>()
    private(set) var didTapBackButtonObservable = PublishSubject<Void>()
    private(set) var didSelectNewsObservable = PublishSubject<Article>()
    private(set) var viewDidDisappearObservable = PublishSubject<Void>()

    private let apiSource: NewsAPISource
    private let disposeBag = DisposeBag()

    // MARK: Lifecycle

    init(apiSource: NewsAPISource) {
        self.apiSource = apiSource

        self.buildControllerBindings()
    }

    // MARK: Functions

    func resetViewModelObservables() {
        self.searchNewsObservable = PublishSubject<[Article]>()
        self.didTapBackButtonObservable = PublishSubject<Void>()
        self.didSelectNewsObservable = PublishSubject<Article>()
        self.viewDidDisappearObservable = PublishSubject<Void>()
    }

    func didSelectNews(with news: Article) {
        self.didSelectNewsObservable.onNext(news)
    }

    func viewDidDisappear() {
        self.viewDidDisappearObservable.onNext(())
    }

    private func buildControllerBindings() {
        self.bindSearchTextObservable()
    }

    private func bindSearchTextObservable() {
        self.searchBarTextObservable
            .distinctUntilChanged()
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .flatMap { [weak self] text -> Observable<News> in
                guard let self else { return .empty() }

                return self.apiSource.sendGetSearchNews(withKeywords: text, forPage: 1)
                    .retry(3)
                    .catchAndReturn(.empty)
            }
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .map { currentNews -> [Article] in
                guard let newsArticles = currentNews.articles else { return .init() }
                return newsArticles.filter { $0.urlToImage != nil }
            }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self else { return }

                self.searchNewsObservable.onNext(result)
            })
            .disposed(by: self.disposeBag)
    }
}
