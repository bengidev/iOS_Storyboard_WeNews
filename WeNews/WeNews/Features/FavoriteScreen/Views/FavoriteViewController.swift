//
//  FavoriteViewController.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 25/11/24.
//

import UIKit

class FavoriteViewController: UIViewController, AppStoryboard {
    // MARK: Static Properties

    static var id: String = "FavoriteViewController"

    static var name: String = "FavoriteStoryboard"

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

    static func generateController() -> (any UIViewController & AppStoryboard)? {
        let bundle = Bundle(for: FavoriteViewController.self)
        let id = FavoriteViewController.id
        let name = FavoriteViewController.name
        let storyboard = UIStoryboard(name: name, bundle: bundle)

        if let viewController = storyboard.instantiateViewController(withIdentifier: id)
            as? FavoriteViewController
        { return viewController }

        assertionFailure("Creating FavoriteViewController from storyboard should be successful")
        return nil
    }
}
