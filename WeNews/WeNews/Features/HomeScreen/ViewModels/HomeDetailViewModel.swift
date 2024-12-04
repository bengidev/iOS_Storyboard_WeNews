//
//  HomeDetailViewModel.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 03/12/24.
//

import Foundation
import RxCocoa
import RxSwift
import SwiftSoup

class HomeDetailViewModel {
    // MARK: Properties

    private(set) var renewedArticleObservable = PublishSubject<Article>()
    private(set) var viewDidDisappearObservable = PublishSubject<Void>()

    private let disposeBag = DisposeBag()

    // MARK: Lifecycle

    init() {}

    // MARK: Functions

    func resetViewModelObservables() {
        self.renewedArticleObservable = PublishSubject<Article>()
        self.viewDidDisappearObservable = PublishSubject<Void>()
    }

    func renewContentFromArticle(_ article: Article) {
        let request = NSMutableURLRequest()
        request.url = .init(string: (article.url) ?? .init())
        request.cachePolicy = .useProtocolCachePolicy
        request.timeoutInterval = 5.0

        URLSession.shared.rx.data(request: request as URLRequest)
            .map { [weak self] data -> String? in
                guard let self else { return .init() }

                let encodedString = String(data: data, encoding: .utf8)
                return self.extractArticleContent(from: encodedString ?? .init())
            }
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMapLatest { content -> Observable<Article> in
                return .just(article.with(content: content))
            }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self else { return }

                self.renewedArticleObservable.onNext(result)
            })
            .disposed(by: self.disposeBag)
    }

    func viewDidDisappear() {
        self.viewDidDisappearObservable.onNext(())
    }

    private func extractArticleContent(from html: String) -> String? {
        do {
            let document = try SwiftSoup.parse(html)
            // Use appropriate selectors based on the article's structure
            if let contentElement = try document.select("article").first() {
                return try contentElement.text()
            }
            return nil
        } catch {
            print("Error parsing HTML: \(error.localizedDescription)")
            return nil
        }
    }
}
