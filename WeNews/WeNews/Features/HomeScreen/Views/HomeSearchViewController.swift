//
//  HomeSearchViewController.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 21/11/24.
//

import UIKit

// MARK: - HomeSearchViewController

class HomeSearchViewController: UIViewController, AppStoryboard {
    // MARK: Static Properties

    static var id: String = "HomeSearchViewController"
    static var name: String = "HomeSearchStoryboard"

    // MARK: Properties

    weak var viewModel: HomeSearchViewModel?

    @IBOutlet private var tableView: UITableView!

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

        self.tableView.dataSource = self
        self.tableView.delegate = self
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
        self.resetControllerBindings()
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

        self.viewModel?.setShouldBackToHomeScreen(to: true)
    }

    /// This method is called after the VC’s view has been removed from the view hierarchy.
    /// Use this method to stop listening for notifications or device sensors.
    ///
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    // MARK: Static Functions

    static func generateController() -> (any UIViewController & AppStoryboard)? {
        let bundle = Bundle(for: HomeSearchViewController.self)
        let id = HomeSearchViewController.id
        let name = HomeSearchViewController.name
        let storyboard = UIStoryboard(name: name, bundle: bundle)

        if let viewController = storyboard.instantiateViewController(withIdentifier: id)
            as? HomeSearchViewController
        { return viewController }

        assertionFailure("Creating HomeSearchViewController from storyboard should be successful")
        return nil
    }

    // MARK: Functions

    private func buildFeatureStyles() {
        self.buildNavigationStyle()
    }

    private func buildNavigationStyle() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func resetControllerBindings() {
        self.viewModel?.setShouldBackToHomeScreen(to: false)
    }
}

// MARK: UITableViewDelegate

extension HomeSearchViewController: UITableViewDelegate {}

// MARK: UITableViewDataSource

extension HomeSearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HomeSearchTableViewCell.identifier,
            for: indexPath
        ) as? HomeSearchTableViewCell else {
            return .init()
        }

        cell.updateView(withNews: .init(
            image: .dummyIcon,
            title: "Apple debuts The Weeknd: Open Hearts, the first-of-its-kind immersive music experience for Apple Vision Pro",
            body: "Today, Apple released The Weeknd: Open Hearts, a breathtaking immersive music experience from the seven-time diamond-certified artist, available exclusively on Apple Vision Pro for a limited time.")
        )

        return cell
    }
}
