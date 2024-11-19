//
//  HomeViewModel.swift
//  OuRecipes
//
//  Created by ENB Mac Mini M1 on 18/11/24.
//

import Foundation
import RxCocoa
import RxSwift

class HomeViewModel {
    // MARK: Static Properties

    static let instance: HomeViewModel = .init()

    // MARK: Properties

    let tastyFeed: BehaviorSubject<Swift.Result<Tasty, (any Error)>> = .init(value: .failure(NSError(domain: "", code: 1)))

    private let disposeBag = DisposeBag()
    private let tastyAPI = TastyAPISource.instance

    // MARK: Lifecycle

    init() {}

    // MARK: Functions

    func requestTastyFeed() {
        self.tastyAPI.getFoodFeeds()
            .observe(on: MainScheduler.instance)
            .subscribe { event in
                switch event {
                case let .success(tasty):
                    self.tastyFeed.onNext(.success(tasty))
                    dump(tasty, name: "requestTastyFeed")

                case let .failure(error):
                    self.tastyFeed.onNext(.failure(error))
                    dump(error, name: "requestTastyFeed")
                }
            }
            .disposed(by: self.disposeBag)
    }
}
