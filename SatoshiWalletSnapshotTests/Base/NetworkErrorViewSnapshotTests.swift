//
//  NetworkErrorViewSnapshotTests.swift
//  SatoshiWalletSnapshotTests
//
//  Created by Pedro Gabriel on 14/09/22.
//

import XCTest
import SnapshotTesting

@testable import SatoshiWallet

class NetworkErrorViewSnapshotTests: XCTestCase {
    func testNetworkErrorView() {
        let sut = makeSut()
        assert(sut, named: "testNetworkErrorView")
    }
}

extension NetworkErrorViewSnapshotTests {
    func makeSut() -> UINavigationController {
        let viewController = UIViewController()
        let networkErrorView: NetworkErrorView = .fromNib()

        viewController.view.addSubview(networkErrorView)
        networkErrorView.frame = viewController.view.bounds

        let navigationController = UINavigationController(rootViewController: viewController)

        return navigationController
    }
}
