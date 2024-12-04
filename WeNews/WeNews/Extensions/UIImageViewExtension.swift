//
//  UIImageViewExtension.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 04/12/24.
//

import UIKit

extension UIImageView {
    func applyshadowWithCorner(containerView: UIView, cornerRadious: CGFloat) {
        containerView.backgroundColor = .clear
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 1.0
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 5.0
        containerView.layer.shouldRasterize = true
        containerView.layer.rasterizationScale = UIScreen.main.scale
        containerView.layer.masksToBounds = false

        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
    }
}
