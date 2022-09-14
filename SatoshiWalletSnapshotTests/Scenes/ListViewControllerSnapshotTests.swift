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
    func testListViewControllerWithSuccessRequestAndTableView() {
        let sut = makeSut(with: ListServicesSuccessStub())
        assert(sut, named: "testListViewControllerWithSuccessRequestAndTableView")
    }

    func testListViewControllerWithFailureRequest() {
        let sut = makeSut(with: ListServicesFailureStub())
        assert(sut, named: "testListViewControllerWithFailureRequest")
    }
}

extension ListViewControllerSnapshotTests {
    func makeSut(with service: ListServicesProtocol) -> UINavigationController {
        let viewController = ListViewController(viewModel: .init(service: service))
        let navigationController = UINavigationController(rootViewController: viewController)

        return navigationController
    }
}
