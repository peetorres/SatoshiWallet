//
//  ListViewControllerSnapshotTests.swift
//  SatoshiWalletSnapshotTests
//
//  Created by Pedro Gabriel on 14/09/22.
//

import XCTest
import SnapshotTesting

@testable import SatoshiWallet

class ListViewControllerSnapshotTests: XCTestCase {
    var sut: ListViewController!

    func testListViewControllerWithSuccessRequestAndTableView() {
        let viewController = ListViewController(viewModel: .init(service: ListServicesSuccessStub()))

        let navigationController = UINavigationController(rootViewController: viewController)
        verifyViewController(navigationController, named: "testListViewControllerWithSuccessRequestAndTableView")
    }
}
