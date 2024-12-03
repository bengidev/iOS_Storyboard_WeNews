//
//  News.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 03/12/24.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let news = try News(json)

import Foundation

// MARK: - News

struct News: Identifiable, Equatable, Codable, Sendable {
    var id = UUID()

    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

// MARK: News convenience initializers and mutators

extension News {
    enum CodingKeys: CodingKey {
        case status
        case totalResults
        case articles
    }

    static let empty: News = .init(status: nil, totalResults: nil, articles: nil)

    static func == (lhs: News, rhs: News) -> Bool {
        return lhs.id == rhs.id
    }

    init(data: Data) throws {
        self = try newJSONDecoder().decode(News.self, from: data)
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
        status: String?? = nil,
        totalResults: Int?? = nil,
        articles: [Article]?? = nil
    ) -> News {
        return News(
            status: status ?? self.status,
            totalResults: totalResults ?? self.totalResults,
            articles: articles ?? self.articles
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return try String(data: self.jsonData(), encoding: encoding)
    }
}
