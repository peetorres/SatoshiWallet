//
//  CryptoFormattingTests.swift
//  SatoshiWalletTests
//
//  Created by Pedro Gabriel on 13/09/22.
//

import XCTest
@testable import SatoshiWallet

class CryptoFormattingTests: XCTestCase {
    // MARK: Properties
    var sut: Crypto!
    let symbol = "BTC"

    // MARK: Setup
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Crypto(asset: makeAsset(symbol: symbol),
                     ticker: makeTicker(symbol: CryptoMapper.formattedTicker(of: symbol)))
    }

    // MARK: Tests
    func testCryptoEqualTrue() {
        let expectedResult = Crypto(asset: makeAsset(symbol: symbol),
                                    ticker: makeTicker(symbol: CryptoMapper.formattedTicker(of: symbol)))
        XCTAssertEqual(sut, expectedResult)
    }

    func testCryptoEqualFalse() {
        let chsbSymbol = "CHSB"
        let expectedResult = Crypto(asset: makeAsset(symbol: chsbSymbol),
                                    ticker: makeTicker(symbol: CryptoMapper.formattedTicker(of: chsbSymbol)))
        XCTAssertNotEqual(sut, expectedResult)
    }

    func testImageURL() {
        let expectedUrl: URL? = URL(string: "https://assets.coincap.io/assets/icons/btc@2x.png")
        XCTAssertEqual(sut.imageUrl(), expectedUrl)
    }

    func testPriceFormatted() {
        let expectedPrice: String? = "$22297.00"
        XCTAssertEqual(sut.priceFormatted(), expectedPrice)
    }

    func testIsChangePercentPositive() {
        XCTAssertTrue(sut.isChangePercentPositive())
    }

    func testIsChangePercentPositiveFalse() {
        let given = Crypto(asset: makeAsset(symbol: symbol),
                           ticker: makeTicker(symbol: CryptoMapper.formattedTicker(of: symbol),
                                              dailyChangeRelative: -2.0))
        XCTAssertFalse(given.isChangePercentPositive())
    }

    func testIsChangePercentPositiveZeroTrue() {
        let given = Crypto(asset: makeAsset(symbol: symbol),
                           ticker: makeTicker(symbol: CryptoMapper.formattedTicker(of: symbol),
                                              dailyChangeRelative: 0))
        XCTAssertTrue(given.isChangePercentPositive())
    }

    func testVariationFormatted() {
        let expectedPercentage: String? = "0.27%"
        XCTAssertEqual(sut.variationFormatted(), expectedPercentage)
    }

    func testMaxSupplyFormatted() throws {
        let expectedSupply: String = "21000000"
        let givenSupply = try XCTUnwrap(sut.maxSupplyFormatted())
        XCTAssertEqual(givenSupply, expectedSupply)
    }

    func testCirculatingSupplyFormatted() throws {
        let expectedCirculatingSupply: String = "19149318"
        let givenCirculatingSupply = try XCTUnwrap(sut.circulatingSupplyFormatted())
        XCTAssertEqual(givenCirculatingSupply, expectedCirculatingSupply)
    }
}

// MARK: Helpers
private extension CryptoFormattingTests {
    func makeAsset(symbol: String) -> Asset {
        .init(id: "bitcoin",
              rank: "1",
              symbol: symbol,
              name: "Bitcoin",
              supply: "19149318.0000000000000000",
              maxSupply: "21000000.0000000000000000",
              marketCapUsd: "427531121779.9066612770085938",
              volumeUsd24Hr: "18216323058.0585357529198306",
              priceUsd: "22326.1800644757511091",
              changePercent24Hr: "1.0544276026677274",
              explorer: "https://blockchain.info/")
    }

    func makeTicker(symbol: String,
                    dailyChangeRelative: Float = 0.0027) -> Ticker {
        .init(symbol: symbol,
              bid: 22295,
              bidSize: 34.17322311,
              ask: 22298,
              askSize: 66.63345830000002,
              dailyChange: 60,
              dailyChangeRelative: dailyChangeRelative,
              lastPrice: 22297,
              dailyVolume: 7467.02603072,
              dailyHigh: 22626,
              dailyLow: 21973)
    }
}
