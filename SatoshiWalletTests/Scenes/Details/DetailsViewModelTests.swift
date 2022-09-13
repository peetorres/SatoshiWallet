//
//  DetailsViewModelTests.swift
//  SatoshiWalletTests
//
//  Created by Pedro Gabriel on 13/09/22.
//

import XCTest
@testable import SatoshiWallet

class DetailsViewModelTests: XCTestCase {
    // MARK: Properties
    var sut: DetailsViewModel!

    // MARK: Setup
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    // MARK: Test Methods
    func testViewFormattingWithBTC() {
        sut = .init(crypto: .makeBTC())

        XCTAssertEqual(sut.imageUrl(), URL(string: "https://assets.coincap.io/assets/icons/btc@2x.png"))
        XCTAssertEqual(sut.rank(), "#1")
        XCTAssertEqual(sut.symbol(), "BTC")
        XCTAssertEqual(sut.name(), "Bitcoin")
        XCTAssertEqual(sut.price(), "$20104.00")
        XCTAssertEqual(sut.isChangePercentPositive(), false)
        XCTAssertEqual(sut.variation(), "-10.60%")
        XCTAssertEqual(sut.maxSupply(), "Max Supply: 21000000")
        XCTAssertEqual(sut.circulatingSupply(), "Circulating Supply: 19149925")
        XCTAssertEqual(sut.explorer(), "Explorer: https://blockchain.info/")
    }

    func testViewFormattingWithETH() {
        sut = .init(crypto: .makeETH())

        XCTAssertEqual(sut.imageUrl(), URL(string: "https://assets.coincap.io/assets/icons/eth@2x.png"))
        XCTAssertEqual(sut.rank(), "#2")
        XCTAssertEqual(sut.symbol(), "ETH")
        XCTAssertEqual(sut.name(), "Ethereum")
        XCTAssertEqual(sut.price(), "$1588.80")
        XCTAssertEqual(sut.isChangePercentPositive(), false)
        XCTAssertEqual(sut.variation(), "-7.58%")
        XCTAssertEqual(sut.maxSupply(), nil)
        XCTAssertEqual(sut.circulatingSupply(), "Circulating Supply: 122355980.9365")
        XCTAssertEqual(sut.explorer(), "Explorer: https://etherscan.io/")
    }

    func testViewFormattingWithCHSB() {
        sut = .init(crypto: .makeCHSB())

        XCTAssertEqual(sut.imageUrl(), URL(string: "https://assets.coincap.io/assets/icons/chsb@2x.png"))
        XCTAssertEqual(sut.rank(), "#100")
        XCTAssertEqual(sut.symbol(), "CHSB")
        XCTAssertEqual(sut.name(), "SwissBorg")
        XCTAssertEqual(sut.price(), "$0.23")
        XCTAssertEqual(sut.isChangePercentPositive(), true)
        XCTAssertEqual(sut.variation(), "10.00%")
        XCTAssertEqual(sut.maxSupply(), nil)
        XCTAssertEqual(sut.circulatingSupply(), "Circulating Supply: 1000000000")
        // swiftlint:disable:next line_length
        XCTAssertEqual(sut.explorer(), "Explorer: https://etherscan.io/token/0xba9d4199fab4f26efe3551d490e3821486f135ba")
    }

    func testViewFormattingWithDUMMY() {
        sut = .init(crypto: .makeDUMMY())

        XCTAssertEqual(sut.imageUrl(), URL(string: "https://assets.coincap.io/assets/icons/dummy@2x.png"))
        XCTAssertEqual(sut.rank(), "#100000")
        XCTAssertEqual(sut.symbol(), "DUMMY")
        XCTAssertEqual(sut.name(), "DUMMY TEST")
        XCTAssertEqual(sut.price(), "$0.00")
        XCTAssertEqual(sut.isChangePercentPositive(), true)
        XCTAssertEqual(sut.variation(), "0.00%")
        XCTAssertEqual(sut.maxSupply(), nil)
        XCTAssertEqual(sut.circulatingSupply(), "Circulating Supply: -")
        XCTAssertEqual(sut.explorer(), nil)
    }
}
