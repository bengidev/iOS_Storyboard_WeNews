//
//  JSONCodingKey.swift
//  OuRecipes
//
//  Created by ENB Mac Mini M1 on 18/11/24.
//

import Foundation

class JSONCodingKey: CodingKey {
    // MARK: Properties

    let key: String

    // MARK: Computed Properties

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return self.key
    }

    // MARK: Lifecycle

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        self.key = stringValue
    }
}
