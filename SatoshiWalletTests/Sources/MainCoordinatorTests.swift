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
}
