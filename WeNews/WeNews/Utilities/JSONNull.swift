//
//  JSONNull.swift
//  OuRecipes
//
//  Created by ENB Mac Mini M1 on 18/11/24.
//

import Foundation

class JSONNull: Codable, Hashable {
    // MARK: Computed Properties

    public var hashValue: Int {
        return 0
    }

    // MARK: Lifecycle

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    // MARK: Static Functions

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    // MARK: Functions

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
