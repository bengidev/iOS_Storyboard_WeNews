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
    // MARK: Properties

    let selectedScreen = BehaviorSubject<MainScreenType>(value: .home)

    // MARK: Lifecycle

    init() {}

    // MARK: Functions

    func changeSelectedScreen(to value: MainScreenType) {
        switch value {
        case .home:
            self.selectedScreen.onNext(.home)
        case .favorite:
            self.selectedScreen.onNext(.favorite)
        }
    }
}
