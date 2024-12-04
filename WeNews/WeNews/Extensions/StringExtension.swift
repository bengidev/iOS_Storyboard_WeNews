//
//  StringExtension.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 04/12/24.
//

import Foundation

extension String {
    func dateFormatted(
        with dateFormat: String = "dd/M/yyyy, H:mm",
        calendar: Calendar = Calendar(identifier: .iso8601),
        defaultDate: Date? = nil, locale:
        Locale = .current,
        timeZone: TimeZone = .current
    ) -> Date? {
        let formatter = DateFormatter()

        formatter.calendar = calendar
        formatter.defaultDate = defaultDate ?? calendar.date(bySettingHour: 12, minute: 0, second: 0, of: Date())
        formatter.locale = locale
        formatter.timeZone = timeZone
        formatter.dateFormat = dateFormat

        return formatter.date(from: self)
    }
}
