//
//  UIButtonExtension.swift
//  Interface Project
//
//  Created by ENB Mac Mini M1 on 04/09/24.
//

import UIKit
import DeviceKit

// MARK: For UIButton Usage

extension UIButton {
    func loadAppTitleButtonStyle() {
        switch Device.current.diagonal {
        case ...Device.iPhoneSE.diagonal:
            self.titleLabel?.font = .preferredFont(forTextStyle: .footnote).bold
        case ...Device.iPhoneSE3.diagonal:
            self.titleLabel?.font = .preferredFont(forTextStyle: .subheadline).bold
        default:
            self.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        }
    }
    
    func setHighlightedBackgroundColor(_ highlightedColor: UIColor, darkenPercentage: CGFloat = 10.0) {
        addTarget(self, action: #selector(self.highlightButton), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(self.unhighlightButton), for: [.touchUpInside, .touchDragExit, .touchCancel])

        let originalColor = backgroundColor ?? .gray
        // Calculate the darkened color for the highlighted state
        if let darkenedColor = highlightedColor.darken(by: darkenPercentage) {
            self.highlightedBackgroundColor = darkenedColor
        } else {
            // Fallback to a default darker color if darkening fails
            self.highlightedBackgroundColor = highlightedColor.withAlphaComponent(0.8)
        }

        self.defaultBackgroundColor = originalColor
    }

    @objc private func highlightButton() {
        backgroundColor = self.highlightedBackgroundColor
    }

    @objc private func unhighlightButton() {
        backgroundColor = self.defaultBackgroundColor
    }

    private var highlightedBackgroundColor: UIColor? {
        get {
            return layer.value(forKey: "highlightedBackgroundColor") as? UIColor
        }
        set {
            layer.setValue(newValue, forKey: "highlightedBackgroundColor")
        }
    }

    private var defaultBackgroundColor: UIColor? {
        get {
            return layer.value(forKey: "defaultBackgroundColor") as? UIColor
        }
        set {
            layer.setValue(newValue, forKey: "defaultBackgroundColor")
        }
    }
}
