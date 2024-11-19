//
//  UIColorExtension.swift
//  Interface Project
//
//  Created by ENB Mac Mini M1 on 04/09/24.
//

import Foundation
import UIKit

extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.hasPrefix("#") ? String(hexSanitized.dropFirst()) : hexSanitized

        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        let r = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let g = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let b = CGFloat(rgb & 0xFF) / 255.0

        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }

    /// Returns a darker version of the color by the specified percentage.
    /// - Parameter percentage: The percentage to darken the color (e.g., 20 for 20%).
    /// - Returns: A new UIColor that is darker by the given percentage, or nil if conversion fails.
    func darken(by percentage: CGFloat = 20.0) -> UIColor? {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0

        // Extract the HSB components from the color
        guard self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) else {
            return nil // Return nil if unable to extract HSB components
        }

        // Calculate the new brightness, ensuring it stays within [0, 1]
        let adjustedBrightness = max(brightness - (brightness * (percentage / 100)), 0.0)

        // Return the new darkened color
        return UIColor(hue: hue, saturation: saturation, brightness: adjustedBrightness, alpha: alpha)
    }
}
