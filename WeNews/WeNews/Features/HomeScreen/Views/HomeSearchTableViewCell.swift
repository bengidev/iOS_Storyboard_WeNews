//
//  HomeSearchTableViewCell.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 21/11/24.
//

import Kingfisher
import UIKit

class HomeSearchTableViewCell: UITableViewCell {
    // MARK: Static Properties

    static let identifier = "HomeSearchTableViewCell"

    // MARK: Properties

    private let animationTime = 0.3

    @IBOutlet private var newsIconImage: UIImageView!
    @IBOutlet private var newsTitleLabel: UILabel!
    @IBOutlet private var newsBodyLabel: UILabel!

    // MARK: Overridden Functions

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: Functions

    func updateView(withNews news: SearchNews) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }

            UIView.animate(withDuration: self.animationTime) {
                self.changeIconImage(toMatch: news)
                self.changeTitleLabel(toMatch: news)
                self.changeBodyLabel(toMatch: news)
            }
        }
    }

    private func changeIconImage(toMatch news: SearchNews) {
        self.newsIconImage.roundCorners(.allCorners, radius: 10.0)
        self.newsIconImage.kf.indicatorType = .activity
        self.newsIconImage.kf.setImage(
            with: URL(string: news.image ?? .init()),
            options: [
                .cacheMemoryOnly,
                .transition(.fade(0.3)),
                .fromMemoryCacheOrRefresh,
            ]
        )
    }

    private func changeTitleLabel(toMatch news: SearchNews) {
        self.newsTitleLabel.text = news.title
    }

    private func changeBodyLabel(toMatch news: SearchNews) {
        self.newsBodyLabel.text = news.body
    }
}
