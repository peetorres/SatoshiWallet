//
//  MainCoordinator.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 12/09/22.
//

import UIKit
import RxSwift

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var rootViewController: UIViewController? { get set }

    func start()
}

final class MainCoordinator: Coordinator {
    // MARK: Properties
    var navigationController: UINavigationController
    var rootViewController: UIViewController?
    let bag = DisposeBag()

    // MARK: Initializer
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = ListViewController()
        viewController.selectedCrypto
            .subscribe { [weak self] in self?.navigateToDetails(with: $0) }
            .disposed(by: bag)

        rootViewController = viewController
        navigationController.pushViewController(viewController, animated: false)
    }

    // MARK: Navigation Methods
    func navigateToDetails(with crypto: Crypto) {
        let viewController = DetailsViewController(viewModel: .init(crypto: crypto))
        navigationController.pushViewController(viewController, animated: true)
    }
}
