//
//  String+ExtensionsTests.swift
//  SatoshiWalletTests
//
//  Created by Pedro Gabriel on 13/09/22.
//

import XCTest
@testable import SatoshiWallet

class StringExtensionsTests: XCTestCase {
    func testCurrencyFormatter() {
        let value = "12345"
        let formattedValue = value.currencyFormatting()
        let expectedValue = "$12,345.00"
        XCTAssertEqual(formattedValue, expectedValue)
    }

    func testCurrencyFormatterBrokenValueWithComma() {
        let value = "123,45"
        let formattedValue = value.currencyFormatting()
        XCTAssertNil(formattedValue)
    }

    func testCurrencyFormatterWithBrokenValueWithDots() {
        let value = "123.45"
        let formattedValue = value.currencyFormatting()
        let expectedValue = "$123.45"
        XCTAssertEqual(formattedValue, expectedValue)
    }

    func testCurrencyFormatterWithBrokenValueWithDotsAlreadyFormatted() {
        let value = "$123.45"
        let formattedValue = value.currencyFormatting()
        XCTAssertNil(formattedValue)
    }
}
