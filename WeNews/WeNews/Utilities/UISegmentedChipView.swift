//
//  UISegmentedChipView.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 05/12/24.
//

import UIKit

// MARK: - UISegmentedChipViewDelegate

protocol UISegmentedChipViewDelegate: AnyObject {
    func didTapIndex(index: Int, str: String)
}

// MARK: - UISegmentedChipView

final class UISegmentedChipView: UIView {
    // MARK: Properties

    weak var delegate: UISegmentedChipViewDelegate?
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.bounces = false
        view.delaysContentTouches = false
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        return view
    }()

    private var chipsTitle: [String] = []
    private var selectedItemIndex: Int?
    private var chipViews: [UIChipView] = []

    private lazy var containerView: UIView = {
        let view = UIView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private lazy var filterStackView: UIStackView = {
        let view = UIStackView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 10.0
        return view
    }()

    // MARK: Lifecycle

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configUI()
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.configUI()
    }

    // MARK: Functions

    public func setup(chipsTitle: [String]) {
        self.chipsTitle = chipsTitle
        self.setupChipStackView()
    }

    func configUI() {
        self.addSubview(self.scrollView)
        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.scrollView.heightAnchor.constraint(equalTo: self.heightAnchor),
        ])

        self.scrollView.addSubview(self.containerView)
        NSLayoutConstraint.activate([
            self.containerView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.containerView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.containerView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor),
        ])

        self.containerView.addSubview(self.filterStackView)
        NSLayoutConstraint.activate([
            self.filterStackView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10.0),
            self.filterStackView.topAnchor.constraint(equalTo: self.containerView.topAnchor),
            self.filterStackView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -10.0),
            self.filterStackView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
        ])
    }

    func titleToWidth(text: String) -> CGFloat {
        let size = (text as NSString).boundingRect(
            with: CGSize(width: CGFloat.infinity, height: CGFloat.infinity),
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .footnote)],
            context: nil
        )

        return size.width + 20.0
    }

    private func setupChipStackView() {
        self.chipViews.removeAll()
        self.filterStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for (index, title) in self.chipsTitle.enumerated() {
            let chip = UIChipView()

            chip.setup(title: title)
            chip.didSelect = { [weak self] title in
                guard let self else { return }

                self.selectChip(at: index)
                self.delegate?.didTapIndex(index: index, str: title)
            }

            self.filterStackView.addArrangedSubview(chip)
            self.chipViews.append(chip)

            NSLayoutConstraint.activate([
                chip.widthAnchor.constraint(equalToConstant: self.titleToWidth(text: title)),
            ])

            layoutIfNeeded()
        }

        if !self.chipViews.isEmpty {
            self.selectChip(at: 0)
        }
    }

    private func selectChip(at index: Int) {
        self.selectedItemIndex = index

        for (currentIndex, chip) in self.chipViews.enumerated() {
            chip.isSelected = (currentIndex == index)
        }

        self.scrollToSelectedChip()
    }

    private func scrollToSelectedChip() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            guard let selectedItemIndex = selectedItemIndex else { return }

            UIView.animate(withDuration: 0.1, delay: 0.0, options: .transitionCrossDissolve) {
                let selectedChip = self.chipViews[selectedItemIndex]
                let chipFrame = selectedChip.frame
                let scrollViewFrame = self.scrollView.frame
                let targetContentOffsetX = chipFrame.midX - scrollViewFrame.width / 2

                let contentOffsetX = max(0, min(self.scrollView.contentSize.width - scrollViewFrame.width, targetContentOffsetX))
                self.scrollView.setContentOffset(CGPoint(x: contentOffsetX, y: 0), animated: true)
            }
        }
    }
}
