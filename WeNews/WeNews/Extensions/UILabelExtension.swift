//
//  UILabel.swift
//  OuRecipes
//
//  Created by ENB Mac Mini M1 on 14/11/24.
//

import DeviceKit
import UIKit

extension UILabel {
    func loadAppTitleLabelStyle() {
        guard let customFont = UIFont(name: "Georgia", size: Device.current.diagonal * 6.5) else { return }
        let fontMetrics = UIFontMetrics(forTextStyle: .largeTitle)
        self.font = fontMetrics.scaledFont(for: customFont)
        self.adjustsFontForContentSizeCategory = true
    }

    func loadAppBodyLabelStyle() {
        guard let customFont = UIFont(name: "AppleSDGothicNeo-Regular", size: Device.current.diagonal * 2.5) else { return }
        let fontMetrics = UIFontMetrics(forTextStyle: .headline)
        self.font = fontMetrics.scaledFont(for: customFont)
        self.adjustsFontForContentSizeCategory = true
    }

    func loadAppFootnoteLabelStyle() {
        let customFont: UIFont = .italicSystemFont(ofSize: Device.current.diagonal * 2.5)
        let fontMetrics = UIFontMetrics(forTextStyle: .footnote)
        self.font = fontMetrics.scaledFont(for: customFont)
        self.adjustsFontForContentSizeCategory = true
    }
}
