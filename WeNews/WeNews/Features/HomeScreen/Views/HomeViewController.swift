//
//  HomeViewController.swift
//  OuRecipes
//
//  Created by ENB Mac Mini M1 on 15/11/24.
//

import DeviceKit
import RxCocoa
import RxSwift
import UIKit

// MARK: - HomeViewController

class HomeViewController: UIViewController, AppStoryboard {
    // MARK: Static Properties

    static var id = "HomeViewController"
    static var name = "HomeStoryboard"

    // MARK: Properties

    weak var viewModel: HomeViewModel?

    private let disposeBag = DisposeBag()

    private var selectedCategory: String = .init()
    private var news: [Article] = []

    @IBOutlet private var greetingHeaderLabel: UILabel!
    @IBOutlet private var greetingFooterLabel: UILabel!
    @IBOutlet private var greetingIconImage: UIImageView!
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var segmentedChipView: UISegmentedChipView!
    @IBOutlet private var newsTableView: UITableView!
    @IBOutlet private var newsTableBlurView: UIVisualEffectView!

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

        self.buildFeatureStyles()
        self.buildControllerBindings()
        self.buildViewModelBindings()
        self.buildControllerConfigurations()
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
    }

    // MARK: Static Functions

    static func generateController() -> (any AppStoryboard & UIViewController)? {
        let bundle = Bundle(for: HomeViewController.self)
        let id = HomeViewController.id
        let name = HomeViewController.name
        let storyboard = UIStoryboard(name: name, bundle: bundle)

        if let viewController = storyboard.instantiateViewController(withIdentifier: id)
            as? HomeViewController
        { return viewController }

        assertionFailure("Creating HomeViewController from storyboard should be successful")
        return nil
    }

    // MARK: Functions

    private func buildControllerBindings() {
        self.bindDidFinishFetchNewsObservable()
    }

    private func bindDidFinishFetchNewsObservable() {
        self.viewModel?.didFinishFetchNewsObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self else { return }

                self.updateNewsTableBlurView(to: result)
            })
            .disposed(by: self.disposeBag)
    }

    private func updateNewsTableBlurView(to value: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }

            UIView.animate(withDuration: 0.3, delay: 0.0, options: .transitionCrossDissolve) {
                self.newsTableBlurView.isHidden = value
            }
        }
    }

    private func buildViewModelBindings() {
        self.bindNewsObservable()
    }

    private func bindNewsObservable() {
        self.viewModel?.newsObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self else { return }

                self.updateNews(to: result)
            })
            .disposed(by: self.disposeBag)
    }

    private func updateNews(to value: [Article]) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }

            self.news = value
            self.newsTableView.reloadData()
        }
    }

    private func buildFeatureStyles() {
        self.buildNavigationStyle()
        self.buildHeaderGreetingLabelStyle()
        self.buildFooterGreetingLabelStyle()
        self.buildGreetingIconImageStyle()
        self.buildSearchBarStyle()
    }

    private func buildNavigationStyle() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func buildHeaderGreetingLabelStyle() {
        self.greetingHeaderLabel.buildAppLabelStyle(
            withSize: Device.current.diagonal * 2.5,
            withTextStyle: .footnote,
            withWeightStyle: .heavy
        )
    }

    private func buildFooterGreetingLabelStyle() {
        self.greetingFooterLabel.buildAppLabelStyle(
            withFontName: "Georgia",
            withSize: Device.current.diagonal * 4.5,
            withTextStyle: .largeTitle
        )
    }

    private func buildGreetingIconImageStyle() {
        self.greetingIconImage.roundCorners(.allCorners, radius: 10.0)
    }

    private func buildSearchBarStyle() {
        self.searchBar.delegate = self
    }

    private func buildControllerConfigurations() {
        self.buildSegmentedViewConfiguration()
        self.sendInitialCategoryRequest()
    }

    private func buildSegmentedViewConfiguration() {
        self.segmentedChipView.delegate = self
        self.segmentedChipView.setup(chipsTitle: [
            "All Categories",
            "Business",
            "Entertainment",
            "General",
            "Health",
            "Science",
            "Sports",
            "Technology",
        ])
    }

    private func sendInitialCategoryRequest() {
        self.viewModel?.didTapCategory(to: "general")
    }
}

// MARK: UISearchBarDelegate

extension HomeViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_: UISearchBar) -> Bool {
        self.viewModel?.didTapSearchBar()

        return false
    }
}

// MARK: UISegmentedChipViewDelegate

extension HomeViewController: UISegmentedChipViewDelegate {
    func didTapIndex(index: Int, str: String) {
        self.viewModel?.didTapCategory(to: str.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))
    }
}

// MARK: UITableViewDelegate

extension HomeViewController: UITableViewDelegate {}

// MARK: UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeNewsViewCell.id, for: indexPath) as! HomeNewsViewCell

        cell.updateNewsDetail(to: self.news[indexPath.row])
        return cell
    }
}
