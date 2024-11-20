//
//  CurrentsAPISource.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 20/11/24.
//

import Foundation
import RxCocoa
import RxSwift

class CurrentsAPISource {
    // MARK: Static Properties

    static let instance: CurrentsAPISource = .init()

    // MARK: Properties

    private let baseURL = "https://api.currentsapi.services/v1"

    // MARK: Lifecycle

    private init() {}

    // MARK: Functions

    func sendGetLatestNews() -> Observable<CurrentNews> {
        let headers = [
            "Authorization": "KtD_JcDoWSUKkLzajybYspkfI7Ocn8hJY5s8dB1bGXlKJYVH",
        ]

        let request = NSMutableURLRequest()
        request.url = .init(string: self.baseURL + "/latest-news")
        request.allHTTPHeaderFields = headers
        request.cachePolicy = .useProtocolCachePolicy
        request.timeoutInterval = 5.0
        request.httpMethod = "GET"

        return URLSession.shared.rx.data(request: request as URLRequest)
            .map { data -> CurrentNews in
                return try newJSONDecoder().decode(CurrentNews.self, from: data)
            }
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
    }

    func sendGetSearchNews(withKeywords keywords: String) -> Observable<CurrentNews> {
        let headers = [
            "Authorization": "KtD_JcDoWSUKkLzajybYspkfI7Ocn8hJY5s8dB1bGXlKJYVH",
        ]

        let request = NSMutableURLRequest()
        request.url = .init(string: self.baseURL + "/search?keywords=" + keywords)
        request.allHTTPHeaderFields = headers
        request.cachePolicy = .useProtocolCachePolicy
        request.timeoutInterval = 5.0
        request.httpMethod = "GET"

        return URLSession.shared.rx.data(request: request as URLRequest)
            .map { data -> CurrentNews in
                return try newJSONDecoder().decode(CurrentNews.self, from: data)
            }
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
    }

    func sendGetSearchNews(withCategory category: CategoryNews) -> Observable<CurrentNews> {
        let headers = [
            "Authorization": "KtD_JcDoWSUKkLzajybYspkfI7Ocn8hJY5s8dB1bGXlKJYVH",
        ]

        let request = NSMutableURLRequest()
        request.url = .init(string: self.baseURL + "/search?category=" + category.rawValue)
        request.allHTTPHeaderFields = headers
        request.cachePolicy = .useProtocolCachePolicy
        request.timeoutInterval = 5.0
        request.httpMethod = "GET"

        return URLSession.shared.rx.data(request: request as URLRequest)
            .map { data -> CurrentNews in
                return try newJSONDecoder().decode(CurrentNews.self, from: data)
            }
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
    }

    func sendGetSearchNews(withCountry country: RegionNews) -> Observable<CurrentNews> {
        let headers = [
            "Authorization": "KtD_JcDoWSUKkLzajybYspkfI7Ocn8hJY5s8dB1bGXlKJYVH",
        ]

        let request = NSMutableURLRequest()
        request.url = .init(string: self.baseURL + "/search?country=" + country.rawValue)
        request.allHTTPHeaderFields = headers
        request.cachePolicy = .useProtocolCachePolicy
        request.timeoutInterval = 5.0
        request.httpMethod = "GET"

        return URLSession.shared.rx.data(request: request as URLRequest)
            .map { data -> CurrentNews in
                return try newJSONDecoder().decode(CurrentNews.self, from: data)
            }
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
    }
}
