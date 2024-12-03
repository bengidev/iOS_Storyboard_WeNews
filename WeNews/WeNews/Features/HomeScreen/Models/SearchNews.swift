//
//  SearchNews.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 21/11/24.
//

import Foundation

// MARK: - SearchNews

struct SearchNews: Identifiable, Equatable, Codable, Sendable {
    var id = UUID()

    let image: String?
    let title: String?
    let body: String?

    // MARK: Static Functions
}

// MARK: Source convenience initializers and mutators

extension SearchNews {
    enum CodingKeys: CodingKey {
        case image
        case title
        case body
    }

    static func == (lhs: SearchNews, rhs: SearchNews) -> Bool {
        return lhs.id == rhs.id
    }

    init(data: Data) throws {
        let decoded = try newJSONDecoder().decode(SearchNews.self, from: data)

        self.image = decoded.image
        self.title = decoded.title
        self.body = decoded.body
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
        image: String? = nil,
        title: String? = nil,
        body: String? = nil
    ) -> SearchNews {
        return SearchNews(
            image: image ?? self.image,
            title: title ?? self.title,
            body: body ?? self.body
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return try String(data: self.jsonData(), encoding: encoding)
    }
}
