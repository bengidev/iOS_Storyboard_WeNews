//
//  HomeDetailViewController.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 03/12/24.
//

import Kingfisher
import RxCocoa
import RxSwift
import SwiftSoup
import UIKit

// MARK: - HomeDetailViewController

class HomeDetailViewController: UIViewController, AppStoryboard {
    // MARK: Static Properties

    static var id: String = "HomeDetailViewController"
    static var name: String = "HomeDetailStoryboard"

    // MARK: Properties

    weak var viewModel: HomeDetailViewModel?

    var news: Article?

    @IBOutlet private var newsSourceLabel: UILabel!
    @IBOutlet private var newsPublishedLabel: UILabel!
    @IBOutlet private var newsTitleLabel: UILabel!
    @IBOutlet private var newsImageShellView: UIView!
    @IBOutlet private var newsImageView: UIImageView!
    @IBOutlet private var newsDescriptionLabel: UILabel!
    @IBOutlet private var newsContentLabel: UILabel!
    @IBOutlet private var visualEffectView: UIVisualEffectView!

    private let disposeBag = DisposeBag()
    private let animationTime = 0.3

    // MARK: Lifecycle

    /// Before a view controller is removed from memory, it gets deinitialized.
    /// You usually override deinit() to clean resources that the view controller has allocated that are not freed by ARC.
    ///
    deinit {
        // Clear your objects
        //
    }

    // MARK: Overridden Functions

    /// This Method is loaded once in view controller life cycle.
    /// It's called when all the view are loaded.
    ///
    /// This method call before the bound are defined and rotation happen.
    /// So it's risky to work view size in this method.
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /// This method is called every time before the view is visible to and before any animation is configured.
    /// In this method view has bound but orientation is not set yet.
    ///
    /// You can override this method to perform custom tasks associated with displaying the view
    /// such as hiding fields or disabling actions before the view becomes visible.
    ///
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.buildControllerStyles()
        self.buildRequiredConfigurations()
        self.buildViewModelBindings()
    }

    /// This method is called after the view present on the screen. Usually, save data to core data or start animation
    /// or start playing a video or a sound, or to start collecting data from the network.
    /// This type of task good for this method.
    ///
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    /// This method is called before the view is removed from the view hierarchy.
    /// The view is still on the view hierarchy but not removed yet.
    /// Any unload animations haven’t been configured yet.
    ///
    /// Add code here to handle timers, hide the keyboard, canceling network requests, revert any changes to the parent UI.
    /// Also, this is an ideal place to save the state.
    ///
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    /// This method is called after the VC’s view has been removed from the view hierarchy.
    /// Use this method to stop listening for notifications or device sensors.
    ///
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        self.viewModel?.viewDidDisappear()
    }

    // MARK: Static Functions

    static func generateController() -> (any UIViewController & AppStoryboard)? {
        let bundle = Bundle(for: HomeDetailViewController.self)
        let id = HomeDetailViewController.id
        let name = HomeDetailViewController.name
        let storyboard = UIStoryboard(name: name, bundle: bundle)

        if let viewController = storyboard.instantiateViewController(withIdentifier: id)
            as? HomeDetailViewController
        { return viewController }

        assertionFailure("Creating HomeDetailViewController from storyboard should be successful")
        return nil
    }

    // MARK: Functions

    func extractArticleContent(from html: String) -> String? {
        do {
            let document = try SwiftSoup.parse(html)
            // Use appropriate selectors based on the article's structure
            if let contentElement = try document.select("article").first() {
                return try contentElement.text()
            }
            return nil
        } catch {
            print("Error parsing HTML: \(error.localizedDescription)")
            return nil
        }
    }

    private func buildControllerStyles() {
        self.buildNewsImageStyle()
    }

    private func buildNewsImageStyle() {
        self.newsImageView.applyshadowWithCorner(containerView: self.newsImageShellView, cornerRadious: 10.0)
    }

    private func buildRequiredConfigurations() {
        self.resetObservablesBeforeBindings()
        self.renewNewsDetail()
    }

    private func renewNewsDetail() {
        self.viewModel?.renewContentFromArticle(self.news ?? .empty)
    }
    
    private func resetObservablesBeforeBindings() {
        self.viewModel?.resetViewModelObservables()
    }

    private func buildViewModelBindings() {
        self.bindRenewedArticleObservable()
    }

    private func bindRenewedArticleObservable() {
        self.viewModel?.renewedArticleObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self else { return }

                self.updateDetailNews(from: result)
            })
            .disposed(by: self.disposeBag)
    }

    private func updateDetailNews(from value: Article) {
        self.shouldShowLoadingView(false)

        DispatchQueue.main.async { [weak self] in
            guard let self else { return }

            self.newsSourceLabel.text = value.source?.name
            self.newsPublishedLabel.text = value.publishedAt?.localeFormatted()
            self.newsTitleLabel.text = value.title
            self.changeImageFromURL(self.newsImageView, withURL: value.urlToImage ?? .init())
            self.newsDescriptionLabel.text = value.description
            self.newsContentLabel.text = value.content
        }
    }

    private func changeImageFromURL(_ view: UIImageView, withURL url: String) {
        DispatchQueue.main.async {
            view.kf.indicatorType = .activity
            view.kf.setImage(
                with: URL(string: url),
                options: [
                    .cacheMemoryOnly,
                    .transition(.fade(0.3)),
                    .fromMemoryCacheOrRefresh,
                ]
            )
        }
    }

    private func shouldShowLoadingView(_ value: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }

            UIView.animate(withDuration: self.animationTime) {
                self.visualEffectView.isHidden = !value
            }
        }
    }
}
