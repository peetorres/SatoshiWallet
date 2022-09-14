//
//  MainCoordinatorTests.swift
//  SatoshiWalletTests
//
//  Created by Pedro Gabriel on 13/09/22.
//

import XCTest
@testable import SatoshiWallet

class MainCoordinatorTests: XCTestCase {
    // MARK: Test Methods
    func testApplicationInitializatingInList() {
        let sut = MainCoordinator()
        sut.start()
        _ = sut.navigationController.view

        checkMemoryLeak(for: sut)

        XCTAssertTrue(sut.rootViewController is ListViewController)
    }

    func testHandleSelectionOfListNavigateToDetail() throws {
        let sut = MainCoordinator(navigationController: NavigationControllerSpy())
        let viewModel = ListViewModel(service: ListServicesSuccessStub())
        let viewController = ListViewController(viewModel: viewModel)
        sut.start(with: viewController)

        checkMemoryLeak(for: sut)

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
