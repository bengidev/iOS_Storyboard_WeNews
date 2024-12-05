//
//  UIChipView.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 05/12/24.
//

import Foundation
import UIKit

final class UIChipView: UIView {
    // MARK: Properties

    var didSelect: ((String) -> Void)?
    var chipRadius: Float?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = UIColor.darkGray
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()

    private lazy var backgroundContainerView: UIView = {
        let view = UIView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        view.layer.cornerRadius = CGFloat(self.chipRadius ?? 10.0)
        view.clipsToBounds = true
        return view
    }()

    // MARK: Computed Properties

    var isSelected: Bool = false {
        didSet {
            self.updateSelection()
        }
    }

    // MARK: Lifecycle

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setupView()
    }

    // MARK: Functions

    func setupView() {
        self.addSubview(self.backgroundContainerView)
        NSLayoutConstraint.activate([
            self.backgroundContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundContainerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.backgroundContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])

        self.backgroundContainerView.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.backgroundContainerView.leadingAnchor, constant: 8.0),
            self.titleLabel.topAnchor.constraint(equalTo: self.backgroundContainerView.topAnchor, constant: 8.0),
            self.titleLabel.rightAnchor.constraint(equalTo: self.backgroundContainerView.rightAnchor, constant: -8.0),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.backgroundContainerView.bottomAnchor, constant: -8.0),
        ])

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleGesture))
        self.backgroundContainerView.addGestureRecognizer(tap)
        self.backgroundContainerView.isUserInteractionEnabled = true
    }

    func setup(title: String) {
        self.titleLabel.text = title
    }

    @objc func handleGesture() {
        self.didSelect?(self.titleLabel.text ?? "")
    }

    private func updateSelection() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }

            UIView.animate(withDuration: 0.1, delay: 0.0, options: .transitionCrossDissolve) {
                if self.isSelected {
                    self.titleLabel.textColor = UIColor.black
                    self.titleLabel.font = .preferredFont(forTextStyle: .headline)
                    self.backgroundContainerView.backgroundColor = UIColor.lightGray
                } else {
                    self.titleLabel.textColor = UIColor.darkGray
                    self.titleLabel.font = .preferredFont(forTextStyle: .subheadline)
                    self.backgroundContainerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
                }
            }
        }
    }
}
