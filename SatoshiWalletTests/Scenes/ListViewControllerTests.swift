//
//  ListViewControllerTests.swift
//  SatoshiWalletTests
//
//  Created by Pedro Gabriel on 08/09/22.
//

import XCTest
@testable import SatoshiWallet

class ListViewControllerTests: XCTestCase {
    // MARK: Properties
    var sut: ListViewController!

    // MARK: Setup
    override func setUpWithError() throws {
        try? super.setUpWithError()
        sut = ListViewController()
        _ = sut.view
    }

    // MARK: Test Controller Behaviors
    func testInitWithCoder() {
        testInitWithCoder(of: sut)
    }

    // MARK: Test Screen Elements
    func testNavigationTitle() {
        XCTAssertEqual(sut.title, "Satoshi Wallet")
    }
}
