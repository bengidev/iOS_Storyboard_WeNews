//
//  UIFont.swift
//  OuRecipes
//
//  Created by ENB Mac Mini M1 on 14/11/24.
//

import UIKit

extension UIFont {
    var bold: UIFont { return self.withWeight(.bold) }
    var semibold: UIFont { return self.withWeight(.semibold) }
    var medium: UIFont { return self.withWeight(.medium) }
    var black: UIFont { return self.withWeight(.black) }
    var heavy: UIFont { return self.withWeight(.heavy) }
    var light: UIFont { return self.withWeight(.light) }
    var regular: UIFont { return self.withWeight(.regular) }
    var thin: UIFont { return self.withWeight(.thin) }
    var ultraLight: UIFont { return self.withWeight(.ultraLight) }

    @available(iOS 13.0, *)
    func rounded() -> UIFont {
        guard let descriptor = fontDescriptor.withDesign(.rounded) else {
            return self
        }

        return UIFont(descriptor: descriptor, size: pointSize)
    }

    @available(iOS 13.0, *)
    func monospaced() -> UIFont {
        guard let descriptor = fontDescriptor.withDesign(.monospaced) else {
            return self
        }

        return UIFont(descriptor: descriptor, size: pointSize)
    }

    @available(iOS 13.0, *)
    func serif() -> UIFont {
        guard let descriptor = fontDescriptor.withDesign(.serif) else {
            return self
        }

        return UIFont(descriptor: descriptor, size: pointSize)
    }

    private func withWeight(_ weight: UIFont.Weight) -> UIFont {
        var attributes = fontDescriptor.fontAttributes
        var traits = (attributes[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]

        traits[.weight] = weight

        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = familyName

        let descriptor = UIFontDescriptor(fontAttributes: attributes)

        return UIFont(descriptor: descriptor, size: pointSize)
    }
}
