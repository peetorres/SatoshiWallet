//
//  MainCoordinator.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 12/09/22.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var rootViewController: UIViewController? { get set }

    func start(with viewController: UIViewController)
}

final class MainCoordinator: Coordinator {
    // MARK: Properties
    var navigationController: UINavigationController
    var rootViewController: UIViewController?

    // MARK: Initializer
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
    }

    func start(with viewController: UIViewController = ListViewController()) {
        if let viewController = viewController as? ListViewController {
            viewController.handleSelection = { [weak self] crypto in
                self?.navigateToDetails(with: crypto)
            }

            rootViewController = viewController
            navigationController.pushViewController(viewController, animated: false)
        }
    }

    // MARK: Navigation Methods
    func navigateToDetails(with crypto: Crypto) {
        let viewController = DetailsViewController(viewModel: .init(crypto: crypto))
        navigationController.pushViewController(viewController, animated: true)
    }
}
