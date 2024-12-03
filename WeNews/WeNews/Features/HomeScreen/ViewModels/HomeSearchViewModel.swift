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
    private(set) var searchNewsObservable = PublishSubject<[SearchNews]>()
    private(set) var didTapBackButtonObservable = PublishSubject<Void>()

    private let apiSource: NewsAPISource

    private let disposeBag = DisposeBag()

    // MARK: Lifecycle

    init(apiSource: NewsAPISource) {
        self.apiSource = apiSource

        self.resetViewModelObservables()
        self.buildControllerBindings()
    }

    // MARK: Functions

    func resetViewModelObservables() {
        self.searchNewsObservable = PublishSubject<[SearchNews]>()
        self.didTapBackButtonObservable = PublishSubject<Void>()
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
            .map { currentNews -> [SearchNews] in
                guard let newsArticles = currentNews.articles else { return .init() }

                let convertedNews = newsArticles.filter { $0.urlToImage != nil }.compactMap {
                    return SearchNews(
                        image: $0.urlToImage,
                        title: $0.title,
                        body: $0.description
                    )
                }

                var searchNews: [SearchNews] = []

                forNews: for news in convertedNews {
                    if searchNews.count == 10 { break forNews }

                    searchNews.append(news)
                }

                return convertedNews
            }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self else { return }

                self.searchNewsObservable.onNext(result)
            })
            .disposed(by: self.disposeBag)
    }
}
