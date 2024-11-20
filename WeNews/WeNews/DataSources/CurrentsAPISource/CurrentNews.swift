//
//  CurrentNews.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 20/11/24.
//

import Foundation

// MARK: - CurrentNews

struct CurrentNews: Identifiable, Codable, Sendable, Equatable {
    let id: UUID = .init()

    let status: String
    let news: [News]
    let page: Int
}

// MARK: CurrentNews convenience initializers and mutators

extension CurrentNews {
    init(data: Data) throws {
        let test = try newJSONDecoder().decode(CurrentNews.self, from: data)

        self.status = test.status
        self.news = test.news
        self.page = test.page
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: Data(contentsOf: url))
    }

    func with(
        status: String? = nil,
        news: [News]? = nil,
        page: Int? = nil
    ) -> CurrentNews {
        return CurrentNews(
            status: status ?? self.status,
            news: news ?? self.news,
            page: page ?? self.page
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return try String(data: self.jsonData(), encoding: encoding)
    }
}

// MARK: CurrentNews.CodingKeys

extension CurrentNews {
    static let empty: CurrentNews = .init(status: "", news: [], page: 0)

    enum CodingKeys: CodingKey {
        case status
        case news
        case page
    }

    static func == (lhs: CurrentNews, rhs: CurrentNews) -> Bool {
        return lhs.id == rhs.id
    }
}
