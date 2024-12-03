//
//  Article.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 03/12/24.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let article = try Article(json)

import Foundation

// MARK: - Article

struct Article: Identifiable, Equatable, Codable, Sendable {
    var id = UUID()

    let source: Source?
    let author: String?
    let title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date?
    let content: String?
}

// MARK: Article convenience initializers and mutators

extension Article {
    enum CodingKeys: CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }

    static let empty: Article = .init(
        source: nil,
        author: nil,
        title: nil,
        description: nil,
        url: nil,
        urlToImage: nil,
        publishedAt: nil,
        content: nil
    )

    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.id == rhs.id
    }

    init(data: Data) throws {
        self = try newJSONDecoder().decode(Article.self, from: data)
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
        source: Source? = nil,
        author: String? = nil,
        title: String? = nil,
        description: String? = nil,
        url: String? = nil,
        urlToImage: String? = nil,
        publishedAt: Date? = nil,
        content: String? = nil
    ) -> Article {
        return Article(
            source: source ?? self.source,
            author: author ?? self.author,
            title: title ?? self.title,
            description: description ?? self.description,
            url: url ?? self.url,
            urlToImage: urlToImage ?? self.urlToImage,
            publishedAt: publishedAt ?? self.publishedAt,
            content: content ?? self.content
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return try String(data: self.jsonData(), encoding: encoding)
    }
}
