//
//  UILabel.swift
//  OuRecipes
//
//  Created by ENB Mac Mini M1 on 14/11/24.
//

import DeviceKit
import UIKit

extension UILabel {
    func loadAppLabelStyle(
        withFontName fontName: String = "Apple SD Gothic Neo",
        witSize size: CGFloat = 17.0,
        withTextStyle style: UIFont.TextStyle = .body
    ) {
        guard let customFont = UIFont(name: fontName, size: size) else { return }
        let fontMetrics = UIFontMetrics(forTextStyle: style)
        self.font = fontMetrics.scaledFont(for: customFont)
        self.adjustsFontForContentSizeCategory = true
    }
}
