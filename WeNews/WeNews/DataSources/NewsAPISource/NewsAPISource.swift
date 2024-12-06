//
//  NewsAPISource.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 03/12/24.
//

import Foundation
import RxCocoa
import RxSwift

class NewsAPISource {
    // MARK: Static Properties

    static let instance: NewsAPISource = .init()

    // MARK: Properties

    private let baseURL = "https://newsapi.org/v2"

    // MARK: Lifecycle

    private init() {}

    // MARK: Functions

    func sendGetTopHeadlines(withCategory category: String, forPage page: Int) -> Observable<News> {
        guard !category.isEmpty else { return .empty() }

        let headers = [
            "Authorization": "955941bd6474428ba0032ea83c63d402",
        ]

        let request = NSMutableURLRequest()
        request.url = .init(string: self.baseURL + "/top-headlines?category=\(category)&page=\(page)")
        request.allHTTPHeaderFields = headers
        request.cachePolicy = .useProtocolCachePolicy
        request.timeoutInterval = 5.0
        request.httpMethod = "GET"

        return URLSession.shared.rx.continueData(request: request as URLRequest)
            .catchAndReturn(.init())
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .map { data -> News in
                return try newJSONDecoder().decode(News.self, from: data)
            }
    }

    func sendGetSearchNews(withKeywords keywords: String, forPage page: Int) -> Observable<News> {
        guard !keywords.isEmpty else { return .empty() }

        let headers = [
            "Authorization": "955941bd6474428ba0032ea83c63d402",
        ]

        let request = NSMutableURLRequest()
        request.url = .init(string: self.baseURL + "/everything?q=\(keywords)&searchIn=title,content&sortBy=relevancy&page=\(page)")
        request.allHTTPHeaderFields = headers
        request.cachePolicy = .useProtocolCachePolicy
        request.timeoutInterval = 5.0
        request.httpMethod = "GET"

        return URLSession.shared.rx.data(request: request as URLRequest)
            .catchAndReturn(.init())
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .map { data -> News in
                return try newJSONDecoder().decode(News.self, from: data)
            }
    }
}
