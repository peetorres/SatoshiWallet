//
//  AppDelegate.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 07/09/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: Properties
    var window: UIWindow?
    var coordinator: MainCoordinator?

    // MARK: App Lifecycle
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        coordinator = MainCoordinator()
        coordinator?.start()

        window?.rootViewController = coordinator?.navigationController
        window?.makeKeyAndVisible()

        AppDelegate.setupNavigationBar()

        return true
    }

    // MARK: Custom Methods
    static func setupNavigationBar() {
        UINavigationBar.appearance().shadowImage = UIImage()

        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(
            UIOffset(horizontal: -1000.0,
                     vertical: 0.0),
            for: .default)
    }
}
