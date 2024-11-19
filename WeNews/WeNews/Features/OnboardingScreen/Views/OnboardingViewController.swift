//
//  OnboardingViewController.swift
//  OuRecipes
//
//  Created by ENB Mac Mini M1 on 08/11/24.
//

import RxCocoa
import RxSwift
import UIKit

final class OnboardingViewController: UIViewController, AppStoryboard {
    // MARK: Static Properties

    static var id = "OnboardingViewController"
    static var name = "OnboardingStoryboard"

    // MARK: Properties

    private let disposeBag: DisposeBag = .init()
    private let viewModel: OnboardingViewModel = .instance

    @IBOutlet private var headerLabels: [UILabel]!
    @IBOutlet private var footerLabel: UILabel!
    @IBOutlet private var getStartedButton: UIButton!

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

        self.loadControllerStyles()
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
        let bundle = Bundle(for: OnboardingViewController.self)
        let id = OnboardingViewController.id
        let name = OnboardingViewController.name
        let storyboard = UIStoryboard(name: name, bundle: bundle)

        if let viewController = storyboard.instantiateViewController(withIdentifier: id)
            as? OnboardingViewController
        { return viewController }

        assertionFailure("Creating OnboardingViewController from storyboard should be successful")
        return nil
    }

    // MARK: Functions

    private func loadControllerStyles() {
        self.buildHeaderLabelStyle()
        self.buildFooterLabelStyle()
        self.buildGetStartedButtonStyle()
    }

    private func buildHeaderLabelStyle() {
        for label in self.headerLabels {
            label.loadAppTitleLabelStyle()
        }
    }

    private func buildFooterLabelStyle() {
        self.footerLabel.loadAppFootnoteLabelStyle()
    }

    private func buildGetStartedButtonStyle() {
        self.getStartedButton.loadAppTitleButtonStyle()
        self.getStartedButton.roundCorners(.allCorners, radius: 15.0)
        self.getStartedButton.setHighlightedBackgroundColor(.background)
    }

    private func buildControllerBindings() {
        self.bindGetStartedButton()
        self.bindOnboardingAccessResult()
    }

    private func bindOnboardingAccessResult() {
        self.viewModel.isOnboardingAccessed.observe(on: MainScheduler.instance).subscribe(onNext: { result in
            dump(result, name: "bindOnboardingAccessResult")
        })
        .disposed(by: self.disposeBag)
    }

    private func bindGetStartedButton() {
        self.getStartedButton.rx.tap.subscribe { [weak self] _ in
            guard let self else { return }

            self.viewModel.setOnboardingAccess(to: true)
            self.viewModel.navigateToHomeScreen()
        }.disposed(by: self.disposeBag)
    }
}
