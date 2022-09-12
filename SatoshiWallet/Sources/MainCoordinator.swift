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

    func start()
}

final class MainCoordinator: Coordinator {
    // MARK: Properties
    var navigationController: UINavigationController
    var rootViewController: UIViewController?

    // MARK: Initializer
    init() {
        navigationController = UINavigationController()
    }

    func start() {
        instanceListViewController()
    }

    // MARK: Navigation Methods
    func instanceListViewController() {
        let viewController = ListViewController()

        viewController.handleSelection = { [weak self] crypto in
            self?.navigateToDetails(with: crypto)
        }

        rootViewController = viewController
        navigationController.pushViewController(viewController, animated: false)
    }

    func navigateToDetails(with crypto: Crypto) {
        let viewController = DetailsViewController(viewModel: .init(crypto: crypto))
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
