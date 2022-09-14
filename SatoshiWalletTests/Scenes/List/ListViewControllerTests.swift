//
//  ListViewControllerTests.swift
//  SatoshiWalletTests
//
//  Created by Pedro Gabriel on 08/09/22.
//

import XCTest
@testable import SatoshiWallet

class ListViewControllerTests: XCTestCase {
    // MARK: Test Controller Behaviors
    func testInitWithCoder() {
        let sut: ListViewController = makeSut()

        testInitWithCoder(of: sut)
    }

    // MARK: Test Screen Elements
    func testNavigationTitle() {
        let sut: ListViewController = makeSut()

        XCTAssertEqual(sut.title, "Satoshi Wallet")
    }

    func testHasRightBarButtonItem() {
        let sut: ListViewController = makeSut()

        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
    }

    func testTableViewCount() {
        let sut: ListViewController = makeSut()

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 5)
    }

    func testTableViewCountEmpty() {
        let sut: ListViewController = makeSut(with: ListServicesEmptySuccessStub())

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }

    func testTableViewCountEmptyNotShowingError() {
        let sut: ListViewController = makeSut(with: ListServicesEmptySuccessStub())

        XCTAssertFalse(sut.view.subviews.last is NetworkErrorView)
    }

    func testTableViewSectionCount() {
        let sut: ListViewController = makeSut()

        XCTAssertEqual(sut.tableView.numberOfSections, 1)
    }

    func testTableViewHandleSelection() throws {
        let sut: ListViewController = makeSut()
        var handleSelection: [(() -> Void)?] = []

        sut.handleSelection = { _ in
            handleSelection.append({})
        }

        let indexPath = IndexPath(row: 0, section: 0)
        sut.tableView(sut.tableView, didSelectRowAt: indexPath)

        XCTAssertEqual(handleSelection.count, 1)
    }

    func testTableViewRegisteringCell() throws {
        let sut: ListViewController = makeSut()

        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.cellForRow(at: indexPath)

        XCTAssertTrue(cell is ListCell)
    }

    func testTableViewReloadingDataWhenSearchLetter() throws {
        let sut: ListViewController = makeSut()

        sut.searchController.searchBar.text = "H"

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 3)
    }

    func testTableViewReloadingDataWhenSearchName() throws {
        let sut: ListViewController = makeSut()

        sut.searchController.searchBar.text = "Ethereum"

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }

    func testSearchEmptyWhenScreenAppears() throws {
        let sut: ListViewController = makeSut()

        let searchText = try XCTUnwrap(sut.searchController.searchBar.text)
        XCTAssertTrue(searchText.isEmpty)
    }

    func testHandlingNetworkErrorViewFirstRequest() {
        let sut: ListViewController = makeSut(with: ListServicesFailureStub())

        XCTAssertTrue(sut.view.subviews.last is NetworkErrorView)
    }

    func testSuccessNotHandlingNetworkErrorViewFirstRequest() {
        let sut: ListViewController = makeSut()

        XCTAssertFalse(sut.view.subviews.last is NetworkErrorView)
    }

    func testNeworkErrorViewButtonIsEnabled() throws {
        let sut: ListViewController = makeSut(with: ListServicesFailureStub())

        let networkErrorView = try XCTUnwrap(sut.view.subviews.last) as? NetworkErrorView
        let buttonTryAgain = try XCTUnwrap(networkErrorView?.tryAgainButton.button)

        XCTAssertTrue(buttonTryAgain.isEnabled)
    }

    func testSuccessNotShowingNetworkErrorToast() {
        let sut: ListViewController = makeSut()

        XCTAssertTrue(sut.viewBackgroundFetchError.isHidden)
    }

    func testUISwitchIsEnabled() {
        let sut: ListViewController = makeSut()

        XCTAssertTrue(sut.switchControl.isUserInteractionEnabled)
    }

    func testUISwitchChangingUserInterface() {
        let sut: ListViewController = makeSut()
        var didChangeInterfaceStyleHandlers: [(() -> Void)?] = []

        sut.didChangeInterfaceStyle = {
            didChangeInterfaceStyleHandlers.append({})
        }

        sut.switchControl.setOn(true, animated: false)
        sut.switchControl.sendActions(for: .valueChanged)

        sut.switchControl.setOn(false, animated: false)
        sut.switchControl.sendActions(for: .valueChanged)

        XCTAssertEqual(didChangeInterfaceStyleHandlers.count, 2)
    }

    func testNeworkErrorTryAgainAction() throws {
        let sut: ListViewController = makeSut(with: ListServicesFailureStub())

        var shouldProgressShow: [(() -> Void)?] = []
        sut.viewModel.shouldProgressShow = { _ in
            shouldProgressShow.append({})
        }

        let networkErrorView = try XCTUnwrap(sut.view.subviews.last) as? NetworkErrorView
        let buttonTryAgain = try XCTUnwrap(networkErrorView?.tryAgainButton.button)
        buttonTryAgain.sendActions(for: .touchUpInside)

        XCTAssertEqual(shouldProgressShow.count, 2)
    }
}

extension ListViewControllerTests {
    func makeSut(with service: ListServicesProtocol = ListServicesSuccessStub(),
                 file: StaticString = #filePath,
                 line: UInt = #line) -> ListViewController {
        let viewModel = ListViewModel(service: service)
        let sut = ListViewController(viewModel: viewModel)

        _ = sut.view

        checkMemoryLeak(for: sut)

        return sut
    }
}
