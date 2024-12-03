//
//  Source.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 03/12/24.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let source = try Source(json)

import Foundation

// MARK: - Source

struct Source: Identifiable, Equatable, Codable, Sendable {
    var id = UUID()

    let name: String?

    // MARK: Static Functions
}

// MARK: Source convenience initializers and mutators

extension Source {
    enum CodingKeys: CodingKey {
        case name
    }

    static let empty: Source = .init(name: nil)

    static func == (lhs: Source, rhs: Source) -> Bool {
        return lhs.id == rhs.id
    }

    init(data: Data) throws {
        let decoded = try newJSONDecoder().decode(Source.self, from: data)

        self.name = decoded.name
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
        name: String?? = nil
    ) -> Source {
        return Source(
            name: name ?? self.name
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return try String(data: self.jsonData(), encoding: encoding)
    }
}
