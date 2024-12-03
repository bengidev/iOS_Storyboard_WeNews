//
//  HomeDetailViewModel.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 03/12/24.
//

import Foundation
import RxCocoa
import RxSwift

class HomeDetailViewModel {
    // MARK: Properties

    private(set) var viewDidDisappearObservable = PublishSubject<Void>()

    // MARK: Lifecycle

    init() {}

    // MARK: Functions

    func resetViewModelObservables() {
        self.viewDidDisappearObservable = PublishSubject<Void>()
    }

    func viewDidDisappear() {
        self.viewDidDisappearObservable.onNext(())
    }
}
