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

    private let disposeBag = DisposeBag()
    private let viewModel = HomeViewModel.instance

    @IBOutlet private var greetingHeaderLabel: UILabel!
    @IBOutlet private var greetingFooterLabel: UILabel!
    @IBOutlet private var greetingIconImage: UIImageView!
    @IBOutlet private var searchBar: UISearchBar!

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

        self.buildControllerBindings()
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

    static func generateController() -> (AppStoryboard & UIViewController)? {
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
//        self.button.rx.tap
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { [weak self] _ in
//                guard let self else { return }
//
//                self.viewModel.requestSearchNews(withCountry: .asia)
//            })
//            .disposed(by: self.disposeBag)
//
//        self.viewModel.currentNews
//            .skip(while: { $0.status.isEmpty })
//            .observe(on: MainScheduler.instance)
//            .subscribe(on: MainScheduler.instance)
//            .subscribe(onNext: { result in
//                dump(result, name: "buildControllerBindings")
//            }, onError: { error in
//                dump(error.localizedDescription, name: "buildControllerBindings")
//            })
//            .disposed(by: self.disposeBag)
    }

    private func buildFeatureStyles() {
        self.buildNavigationStyles()
        self.buildHeaderGreetingLabelStyle()
        self.buildFooterGreetingLabelStyle()
        self.buildGreetingIconImageStyle()
        self.buildSearchBarStyle()
    }

    private func buildNavigationStyles() {
        self.navigationController?.navigationBar.isHidden = true
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

    @objc private func handleSearchBarTapGesture(_ sender: UITapGestureRecognizer) {
        dump(sender, name: "handleSearchBarTapGesture")
    }
}

// MARK: UISearchBarDelegate

extension HomeViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        dump(searchBar, name: "searchBarShouldBeginEditing")

        self.viewModel.navigateToHomeSearchScreen()
        return false
    }
}
