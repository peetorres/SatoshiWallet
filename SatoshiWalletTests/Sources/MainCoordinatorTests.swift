//
//  MainCoordinatorTests.swift
//  SatoshiWalletTests
//
//  Created by Pedro Gabriel on 13/09/22.
//

import XCTest
@testable import SatoshiWallet

class MainCoordinatorTests: XCTestCase {
    // MARK: Properties
    var sut: MainCoordinator!

    // MARK: Setup
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    // MARK: Test Methods
    func testApplicationInitializatingInList() {
        sut = MainCoordinator()
        sut.start()
        _ = sut.navigationController.view

        XCTAssertTrue(sut.rootViewController is ListViewController)
    }

    func testHandleSelectionOfListNavigateToDetail() throws {
        sut = MainCoordinator(navigationController: NavigationControllerSpy())
        let viewModel = ListViewModel(service: ListServicesSuccessStub())
        let viewController = ListViewController(viewModel: viewModel)
        sut.start(with: viewController)
        _ = sut.navigationController.view
        _ = viewController.view

        let indexPath = IndexPath(row: 0, section: 0)
        viewController.tableView(viewController.tableView, didSelectRowAt: indexPath)

        let navigationControllerSpy = try XCTUnwrap(sut.navigationController as? NavigationControllerSpy)
        let nameOfScene: String = navigationControllerSpy.pushedViewController?.description ?? "Unknown"

        XCTAssertTrue(navigationControllerSpy.pushedViewController is DetailsViewController,
                      "Not instanced DetailsViewController, instanced \(nameOfScene) instead")
    }
}
