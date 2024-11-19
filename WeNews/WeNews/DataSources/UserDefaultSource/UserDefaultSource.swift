//
//  UserDefaultSource.swift
//  OuRecipes
//
//  Created by ENB Mac Mini M1 on 14/11/24.
//

import Foundation
import RxSwift

class UserDefaultSource {
    // MARK: Static Properties

    static let instance: UserDefaultSource = .init()

    // MARK: Lifecycle

    private init() {}

    // MARK: Functions

    func getHaveAccessOnboarding() -> Single<Bool> {
        return Single.create { observer in
            DispatchQueue.global(qos: .background).async {
                observer(.success(UserDefaults.standard.bool(forKey: "AccessOnboarding")))
            }

            return Disposables.create()
        }
    }

    func setHaveAccessOnboarding(to value: Bool) {
        UserDefaults.standard.setValue(value, forKey: "AccessOnboarding")
    }
}
