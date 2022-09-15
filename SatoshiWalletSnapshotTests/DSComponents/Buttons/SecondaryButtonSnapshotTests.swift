//
//  SecondaryButtonSnapshotTests.swift
//  SatoshiWalletSnapshotTests
//
//  Created by Pedro Gabriel on 14/09/22.
//

import XCTest
import SnapshotTesting

@testable import SatoshiWallet

class SecondaryButtonSnapshotTests: XCTestCase {
    func testSecondaryButtonNormal() {
        let button = SecondaryButton(frame: .init(x: 0, y: 0, width: 414, height: 50))
        button.title = "Button Title"

        let result = verifySnapshot(matching: button,
                                    as: .image,
                                    named: "testSecondaryButtonNormal",
                                    testName: "testSecondaryButtonNormal")

        XCTAssertNil(result)
    }
}
