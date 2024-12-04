//
//  DateExtension.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 04/12/24.
//

import Foundation

extension Date {
    func localeFormatted() -> String {
        let formatter = DateFormatter()

        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = .current
        formatter.timeZone = .current
        formatter.dateFormat = "dd/M/yyyy, H:mm"

        return formatter.string(from: self)
    }
}
