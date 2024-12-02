//
//  SearchNews.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 21/11/24.
//

import UIKit

// MARK: - SearchNews

struct SearchNews: Identifiable, Sendable, Equatable {
    let id: UUID = .init()

    let image: String
    let title: String
    let body: String
}

extension SearchNews {
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
}

// MARK: SearchNews.CodingKeys

extension SearchNews {
    static let empty: SearchNews = .init(image: .init(), title: .init(), body: .init())

    static func == (lhs: SearchNews, rhs: SearchNews) -> Bool {
        return lhs.id == rhs.id
    }
}
