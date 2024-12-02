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
    private(set) var apiSearchResultObservable = PublishSubject<[SearchNews]>()
    private(set) var didTapBackButtonObservable = PublishSubject<Void>()

    private let apiSource: CurrentsAPISource

    private let disposeBag = DisposeBag()

    // MARK: Lifecycle

    init(apiSource: CurrentsAPISource) {
        self.apiSource = apiSource

        self.buildControllerBindings()
    }

    // MARK: Functions

    func resetViewModelObservables() {
        self.apiSearchResultObservable = PublishSubject<[SearchNews]>()
        self.didTapBackButtonObservable = PublishSubject<Void>()
    }

    private func buildControllerBindings() {
        self.bindSearchTextObservable()
    }

    private func bindSearchTextObservable() {
        self.searchBarTextObservable
            .skip(while: { $0.isEmpty })
            .distinctUntilChanged()
            .debounce(.seconds(3), scheduler: MainScheduler.instance)
            .flatMap { [weak self] text -> Observable<CurrentNews> in
                guard let self else { return .empty() }

                return self.apiSource.sendGetSearchNews(withKeywords: text)
                    .retry(3)
                    .catchAndReturn(.empty)
            }
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .map { currentNews -> [SearchNews] in
                var tempNews = currentNews.news.map { return SearchNews(image: $0.image, title: $0.title, body: $0.description) }
                var searchNews: [SearchNews] = []

                forNews: for news in tempNews {
                    if searchNews.count == 10 { break forNews }

                    searchNews.append(news)
                }

                return searchNews
            }
            .debug()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self else { return }

                dump(result.count, name: "bindSearchTextObservable")
            })
            .disposed(by: self.disposeBag)
    }
}
