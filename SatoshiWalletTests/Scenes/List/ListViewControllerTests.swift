//
//  ListViewControllerTests.swift
//  SatoshiWalletTests
//
//  Created by Pedro Gabriel on 08/09/22.
//

import XCTest
@testable import SatoshiWallet

class NavigationControllerSpy: UINavigationController {
    var pushedViewController: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: true)
    }
}

class ListViewControllerTests: XCTestCase {
    // MARK: Properties
    var sut: ListViewController!

    // Setup
    override func tearDownWithError() throws {
        try? super.tearDownWithError()
        sut = nil
    }

    // MARK: Test Controller Behaviors
    func testInitWithCoder() {
        sut = makeSut()

        testInitWithCoder(of: sut)
    }

    // MARK: Test Screen Elements
    func testNavigationTitle() {
        sut = makeSut()

        XCTAssertEqual(sut.title, "Satoshi Wallet")
    }

    func testHasRightBarButtonItem() {
        sut = makeSut()

        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
    }

    func testTableViewCount() {
        sut = makeSut()

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 5)
    }

    func testTableViewSectionCount() {
        sut = makeSut()

        XCTAssertEqual(sut.tableView.numberOfSections, 1)
    }

    func testTableViewHandleSelection() throws {
        sut = makeSut()
        var handleSelection: [(() -> Void)?] = []

        sut.handleSelection = { _ in
            handleSelection.append({})
        }

        let indexPath = IndexPath(row: 0, section: 0)
        sut.tableView(sut.tableView, didSelectRowAt: indexPath)

        XCTAssertEqual(handleSelection.count, 1)
    }

    func testTableViewRegisteringCell() throws {
        sut = makeSut()

        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.cellForRow(at: indexPath)

        XCTAssertTrue(cell is ListCell)
    }

    func testTableViewReloadingDataWhenSearchLetter() throws {
        sut = makeSut()

        sut.searchController.searchBar.text = "H"

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 3)
    }

    func testTableViewReloadingDataWhenSearchName() throws {
        sut = makeSut()

        sut.searchController.searchBar.text = "Ethereum"

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }

    func testSearchEmptyWhenScreenAppears() throws {
        sut = makeSut()

        let searchText = try XCTUnwrap(sut.searchController.searchBar.text)
        XCTAssertTrue(searchText.isEmpty)
    }

    func testHandlingNetworkErrorViewFirstRequest() {
        sut = makeSut(with: ListServicesFailureStub())

        XCTAssertTrue(sut.view.subviews.last is NetworkErrorView)
    }

    func testSuccessNotHandlingNetworkErrorViewFirstRequest() {
        sut = makeSut()

        XCTAssertFalse(sut.view.subviews.last is NetworkErrorView)
    }

    func testINeworkErrorViewButtonIsEnabled() throws {
        sut = makeSut(with: ListServicesFailureStub())

        let networkErrorView = try XCTUnwrap(sut.view.subviews.last) as? NetworkErrorView
        let buttonTryAgain = try XCTUnwrap(networkErrorView?.tryAgainButton.button)

        XCTAssertTrue(buttonTryAgain.isEnabled)
    }

    func testSuccessNotShowingNetworkErrorToast() {
        sut = makeSut()

        XCTAssertTrue(sut.viewBackgroundFetchError.isHidden)
    }
}

extension ListViewControllerTests {
    func makeSut(with service: ListServicesProtocol = ListServicesSuccessStub(),
                 file: StaticString = #filePath,
                 line: UInt = #line) -> ListViewController {
        let viewModel = ListViewModel(service: service)
        let sut = ListViewController(viewModel: viewModel)

        _ = sut.view

        return sut
    }
}
