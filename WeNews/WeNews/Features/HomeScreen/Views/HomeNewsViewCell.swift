//
//  HomeNewsViewCell.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 05/12/24.
//

import Kingfisher
import UIKit

class HomeNewsViewCell: UITableViewCell {
    // MARK: Static Properties

    static let id: String = "HomeNewsViewCell"

    // MARK: Properties

    @IBOutlet private var newsImageView: UIImageView!
    @IBOutlet private var newsAuthorlabel: UILabel!
    @IBOutlet private var newsTitleLabel: UILabel!
    @IBOutlet private var newsPublishedLabel: UILabel!

    // MARK: Lifecycle

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: Overridden Functions

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: Functions

    func updateNewsDetail(to value: Article) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }

            UIView.animate(withDuration: 0.1, delay: 0.0, options: .transitionCrossDissolve) {
                self.changeIconImage(to: value)
                self.changeAuthorLabel(to: value)
                self.changeTitleLabel(to: value)
                self.changePublishedLabel(to: value)
            }
        }
    }

    private func changeIconImage(to news: Article) {
        self.newsImageView.roundCorners(.allCorners, radius: 10.0)
        self.newsImageView.kf.indicatorType = .activity
        self.newsImageView.kf.setImage(
            with: URL(string: news.urlToImage ?? .init()),
            options: [
                .cacheMemoryOnly,
                .transition(.fade(0.3)),
                .fromMemoryCacheOrRefresh,
            ]
        )
    }

    private func changeAuthorLabel(to value: Article) {
        self.newsAuthorlabel.text = value.author
    }

    private func changeTitleLabel(to value: Article) {
        self.newsTitleLabel.text = value.title
    }

    private func changePublishedLabel(to value: Article) {
        self.newsPublishedLabel.text = value.publishedAt?.localeFormatted()
    }
}
