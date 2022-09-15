//
//  PrimaryButtonSnapshotTests.swift
//  SatoshiWalletSnapshotTests
//
//  Created by Pedro Gabriel on 14/09/22.
//

import XCTest
import SnapshotTesting

@testable import SatoshiWallet

class PrimaryButtonSnapshotTests: XCTestCase {
    func testPrimaryButtonNormal() {
        let button = PrimaryButton(frame: .init(x: 0, y: 0, width: 414, height: 50))
        button.title = "Button Title"
        button.buttonStyle = .normal

        let result = verifySnapshot(matching: button,
                                    as: .image,
                                    named: "testPrimaryButtonNormal",
                                    testName: "testPrimaryButtonNormal")

        XCTAssertNil(result)
    }

    func testPrimaryButtonDestructive() {
        let button = PrimaryButton(frame: .init(x: 0, y: 0, width: 414, height: 50))
        button.title = "Button Title"
        button.buttonStyle = .destructive

        let result = verifySnapshot(matching: button,
                                    as: .image,
                                    named: "testPrimaryButtonDestructive",
                                    testName: "testPrimaryButtonDestructive")

        XCTAssertNil(result)
    }
}
