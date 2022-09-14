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
        isRecording = true
        let sut = makeSut(with: ListServicesSuccessStub())
        verifyViewController(sut, named: "testListViewControllerWithSuccessRequestAndTableView")
    }

    func testListViewControllerWithFailureRequest() {
        isRecording = true
        let sut = makeSut(with: ListServicesFailureStub())
        verifyViewController(sut, named: "testListViewControllerWithFailureRequest")
    }
}

extension ListViewControllerSnapshotTests {
    func makeSut(with service: ListServicesProtocol) -> UINavigationController {
        let viewController = ListViewController(viewModel: .init(service: service))
        let navigationController = UINavigationController(rootViewController: viewController)

        return navigationController
    }
}
