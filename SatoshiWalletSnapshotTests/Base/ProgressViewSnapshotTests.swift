//
//  ProgressViewSnapshotTests.swift
//  SatoshiWalletSnapshotTests
//
//  Created by Pedro Gabriel on 14/09/22.
//

import XCTest
import SnapshotTesting

@testable import SatoshiWallet

class ProgressViewSnapshotTests: XCTestCase {
    func testProgressView() {
        let sut = makeSut()
        assert(sut, named: "testProgressView")
    }
}

extension ProgressViewSnapshotTests {
    func makeSut() -> UINavigationController {
        let viewController = UIViewController()
        let progressView: ProgressView = .fromNib()

        viewController.view.addSubview(progressView)
        progressView.frame = viewController.view.bounds

        let navigationController = UINavigationController(rootViewController: viewController)

        return navigationController
    }
}
