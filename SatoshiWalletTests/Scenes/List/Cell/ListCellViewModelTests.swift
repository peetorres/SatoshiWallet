//
//  ListCellViewModelTests.swift
//  SatoshiWalletTests
//
//  Created by Pedro Gabriel on 13/09/22.
//

import XCTest
@testable import SatoshiWallet

class ListCellViewModelTests: XCTestCase {
    // MARK: Properties
    var sut: ListCellViewModel!

    // MARK: Setup
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    // MARK: Test Methods
    func testViewFormattingWithBTC() {
        sut = .init(crypto: .makeBTC())

        XCTAssertEqual(sut.imageUrl(), URL(string: "https://assets.coincap.io/assets/icons/btc@2x.png"))
        XCTAssertEqual(sut.rank(), "1")
        XCTAssertEqual(sut.symbol(), "BTC")
        XCTAssertEqual(sut.name(), "Bitcoin")
        XCTAssertEqual(sut.price(), "$20104.00")
        XCTAssertEqual(sut.isChangePercentPositive(), false)
        XCTAssertEqual(sut.variation(), "-10.60%")
    }

    func testViewFormattingWithETH() {
        sut = .init(crypto: .makeETH())

        XCTAssertEqual(sut.imageUrl(), URL(string: "https://assets.coincap.io/assets/icons/eth@2x.png"))
        XCTAssertEqual(sut.rank(), "2")
        XCTAssertEqual(sut.symbol(), "ETH")
        XCTAssertEqual(sut.name(), "Ethereum")
        XCTAssertEqual(sut.price(), "$1588.80")
        XCTAssertEqual(sut.isChangePercentPositive(), false)
        XCTAssertEqual(sut.variation(), "-7.58%")
    }

    func testViewFormattingWithCHSB() {
        sut = .init(crypto: .makeCHSB())

        XCTAssertEqual(sut.imageUrl(), URL(string: "https://assets.coincap.io/assets/icons/chsb@2x.png"))
        XCTAssertEqual(sut.rank(), "100")
        XCTAssertEqual(sut.symbol(), "CHSB")
        XCTAssertEqual(sut.name(), "SwissBorg")
        XCTAssertEqual(sut.price(), "$0.23")
        XCTAssertEqual(sut.isChangePercentPositive(), true)
        XCTAssertEqual(sut.variation(), "10.00%")
    }
}
