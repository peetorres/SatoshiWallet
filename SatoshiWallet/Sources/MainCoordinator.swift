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
    var navigationController: UINavigationController
    var rootViewController: UIViewController?

    init() {
        navigationController = UINavigationController()
    }

    func start() {
        let viewController = ListViewController()
        viewController.coordinator = self
        rootViewController = viewController
        navigationController.pushViewController(viewController, animated: false)
    }

    func navigateToDetails(with asset: Asset) {
        let viewController = DetailsViewController(viewModel: .init(asset: asset))
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
