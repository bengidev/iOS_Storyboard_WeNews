//
//  UILabel.swift
//  OuRecipes
//
//  Created by ENB Mac Mini M1 on 14/11/24.
//

import DeviceKit
import UIKit

extension UILabel {
    func buildAppLabelStyle(
        withFontName fontName: String = "Apple SD Gothic Neo",
        withSize size: CGFloat = 17.0,
        withTextStyle style: UIFont.TextStyle = .body,
        withWeightStyle weight: UIFont.Weight = .regular
    ) {
        guard let customFont = UIFont(name: fontName, size: size)?.withWeight(weight) else { return }
        let fontMetrics = UIFontMetrics(forTextStyle: style)
        self.font = fontMetrics.scaledFont(for: customFont)
        self.adjustsFontForContentSizeCategory = true
    }
}
