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
        switch Device.current.diagonal {
        case ...Device.iPhoneSE.diagonal:
            font = .preferredFont(forTextStyle: .headline)
        case ...Device.iPhoneSE3.diagonal:
            font = .preferredFont(forTextStyle: .title1).bold
        default:
            font = .preferredFont(forTextStyle: .largeTitle).bold
        }
    }

    func loadAppBodyLabelStyle() {
        switch Device.current.diagonal {
        case ...Device.iPhoneSE.diagonal:
            font = .preferredFont(forTextStyle: .body).bold
        case ...Device.iPhoneSE3.diagonal:
            font = .preferredFont(forTextStyle: .subheadline).bold
        default:
            font = .preferredFont(forTextStyle: .headline)
        }
    }
    
    func loadAppFootnoteLabelStyle() {
        switch Device.current.diagonal {
        case ...Device.iPhoneSE.diagonal:
            font = .preferredFont(forTextStyle: .caption1)
        case ...Device.iPhoneSE3.diagonal:
            font = .preferredFont(forTextStyle: .footnote)
        default:
            font = .preferredFont(forTextStyle: .subheadline)
        }
    }
}
