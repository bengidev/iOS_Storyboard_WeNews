//
//  HomeSearchTableViewCell.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 21/11/24.
//

import UIKit

class HomeSearchTableViewCell: UITableViewCell {
    // MARK: Static Properties

    static let identifier = "HomeSearchTableViewCell"

    // MARK: Properties

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

            self.changeIconImage(toMatch: news)
            self.changeTitleLabel(toMatch: news)
            self.changeBodyLabel(toMatch: news)
        }
    }

    private func changeIconImage(toMatch news: SearchNews) {
        self.newsIconImage.image = news.image
        self.newsIconImage.roundCorners(.allCorners, radius: 10.0)
    }

    private func changeTitleLabel(toMatch news: SearchNews) {
        self.newsTitleLabel.text = news.title
    }

    private func changeBodyLabel(toMatch news: SearchNews) {
        self.newsBodyLabel.text = news.body
    }
}
