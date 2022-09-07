//
//  AppDelegate.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 07/09/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        let navigationController = UINavigationController(rootViewController: ListViewController())

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}

