//
//  FavoriteCoordinator.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 25/11/24.
//

import Foundation
import RxSwift

class FavoriteCoordinator: BaseCoordinator {
    // MARK: Static Properties

    static let intance: FavoriteCoordinator = .init()

    // MARK: Properties

    private let disposeBag = DisposeBag()

    // MARK: Lifecycle

    override private init() {}

    // MARK: Overridden Functions

    override func start() {}
}
