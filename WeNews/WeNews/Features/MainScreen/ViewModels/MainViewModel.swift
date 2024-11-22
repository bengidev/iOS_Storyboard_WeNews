//
//  MainViewModel.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 22/11/24.
//

import Foundation
import RxCocoa
import RxSwift

class MainViewModel {
    // MARK: Static Properties

    static let instance: MainViewModel = .init()

    // MARK: Properties

    let didSelectScreen = BehaviorSubject(value: MainScreenType.home)

    private let coordinator: MainCoordinator = .intance
    
    // MARK: Lifecycle

    private init() {}

    // MARK: Functions

    func changeSelectedScreen(to value: MainScreenType) {
        self.didSelectScreen.onNext(value)
    }
}
