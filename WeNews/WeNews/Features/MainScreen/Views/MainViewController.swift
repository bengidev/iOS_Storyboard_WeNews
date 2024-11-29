//
//  MainViewController.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 22/11/24.
//

import UIKit

// MARK: - MainViewController

class MainViewController: UITabBarController, AppStoryboard {
    // MARK: Static Properties

    static var id: String = "MainViewController"
    static var name: String = "MainStoryboard"

    // MARK: Properties

    weak var mainViewModel: MainViewModel?
    weak var homeViewModel: HomeViewModel?

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

        self.buildControllerConfigurations()
        self.buildFeatureStyles()
        self.buildTabBarItems()
    }

    /// This method is called every time before the view is visible to and before any animation is configured.
    /// In this method view has bound but orientation is not set yet.
    ///
    /// You can override this method to perform custom tasks associated with displaying the view
    /// such as hiding fields or disabling actions before the view becomes visible.
    ///
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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

    static func generateTabBarController() -> (any UITabBarController & AppStoryboard)? {
        let bundle = Bundle(for: MainViewController.self)
        let id = MainViewController.id
        let name = MainViewController.name
        let storyboard = UIStoryboard(name: name, bundle: bundle)

        if let viewController = storyboard.instantiateViewController(withIdentifier: id)
            as? MainViewController
        { return viewController }

        assertionFailure("Creating MainViewController from storyboard should be successful")
        return nil
    }

    // MARK: Functions

    private func buildControllerConfigurations() {
        self.delegate = self
    }

    private func buildFeatureStyles() {
        self.tabBar.backgroundColor = .init(resource: .background)
        self.tabBar.tintColor = .init(resource: .accent)
        self.tabBar.unselectedItemTintColor = .darkGray
        self.tabBar.isTranslucent = false
    }

    private func buildTabBarItems() {
        let homeScreen = self.buildHomeTabBarItem()
        let favoriteScreen = self.buildFavoriteTabBarItem()

        self.viewControllers = [
            homeScreen,
            favoriteScreen,
        ]
    }

    private func buildHomeTabBarItem() -> UIViewController {
        let homeViewController = HomeViewController.generateController()
        guard let homeScreen = homeViewController as? HomeViewController else { return .init() }
        homeScreen.viewModel = self.homeViewModel
        homeScreen.tabBarItem = .init(title: "Home", image: .homeUnselectIcon, selectedImage: .homeSelectIcon)

        return homeScreen
    }

    private func buildFavoriteTabBarItem() -> UIViewController {
        let favoriteViewController = FavoriteViewController.generateController()
        guard let favoriteScreen = favoriteViewController as? FavoriteViewController else { return .init() }
        favoriteScreen.tabBarItem = .init(title: "Favorite", image: .favoriteUnselectIcon, selectedImage: .favoriteSelectIcon)

        return favoriteScreen
    }
}

// MARK: UITabBarControllerDelegate

extension MainViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.buildScreenMoveAnimation(withItem: item)

        if let titleLowercased = item.title?.lowercased() {
            self.sendSelectedScreenToViewModel(with: titleLowercased)
        }
    }

    private func buildScreenMoveAnimation(withItem item: UITabBarItem) {
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }

        let timeInterval: TimeInterval = 0.3
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
        }

        propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()
    }

    private func sendSelectedScreenToViewModel(with value: String) {
        if value == "home" {
            self.mainViewModel?.changeSelectedScreen(to: .home)
        } else if value == "favorite" {
            self.mainViewModel?.changeSelectedScreen(to: .favorite)
        }
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let fromView = selectedViewController?.view, let toView = viewController.view else { return false }

        self.buildTabItemAnimation(fromView, toView)

        return true
    }

    private func buildTabItemAnimation(_ fromView: UIView, _ toView: UIView) {
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve])
        }
    }
}
