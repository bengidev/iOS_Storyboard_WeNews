//
//  News.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 20/11/24.
//

import Foundation

// MARK: - News

struct News: Identifiable, Equatable, Codable, Sendable {
    let id: String
    let title: String
    let description: String
    let url: String
    let author: String
    let image: String
    let category: [String]
    let published: String
}

// MARK: News convenience initializers and mutators

extension News {
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
        id: String? = nil,
        title: String? = nil,
        description: String? = nil,
        url: String? = nil,
        author: String? = nil,
        image: String? = nil,
        category: [String]? = nil,
        published: String? = nil
    ) -> News {
        return News(
            id: id ?? self.id,
            title: title ?? self.title,
            description: description ?? self.description,
            url: url ?? self.url,
            author: author ?? self.author,
            image: image ?? self.image,
            category: category ?? self.category,
            published: published ?? self.published
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return try String(data: self.jsonData(), encoding: encoding)
    }
}
