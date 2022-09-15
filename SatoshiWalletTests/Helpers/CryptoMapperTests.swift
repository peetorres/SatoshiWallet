//
//  CryptoMapperTests.swift
//  SatoshiWalletTests
//
//  Created by Pedro Gabriel on 13/09/22.
//

import XCTest
@testable import SatoshiWallet

class CryptoMapperTests: XCTestCase {
    func testTicketFormatter() {
        XCTAssertEqual(CryptoMapper.formattedTicker(of: "BTC"), "tBTCUSD")
        XCTAssertEqual(CryptoMapper.formattedTicker(of: "ETH"), "tETHUSD")
        XCTAssertEqual(CryptoMapper.formattedTicker(of: "CHSB"), "tCHSB:USD")
        XCTAssertEqual(CryptoMapper.formattedTicker(of: "LINK"), "tLINK:USD")
        XCTAssertEqual(CryptoMapper.formattedTicker(of: "DOGE"), "tDOGE:USD")
        XCTAssertEqual(CryptoMapper.formattedTicker(of: "SHIBA"), "tSHIBA:USD")
    }

    func testTickerArrayFromAssets() {
        let assets: [Asset] = [makeAsset(symbol: "BTC"),
                               makeAsset(symbol: "ETH"),
                               makeAsset(symbol: "CHSB"),
                               makeAsset(symbol: "LINK")]

        let array = CryptoMapper.tickerArray(from: assets)

        let expectedArray = ["tBTCUSD", "tETHUSD", "tCHSB:USD", "tLINK:USD"]

        XCTAssertEqual(array, expectedArray)
    }

    func testCryptoArrayMappingAssetsAndTickersEqualValues() {
        let assets: [Asset] = [makeAsset(symbol: "BTC"),
                               makeAsset(symbol: "ETH"),
                               makeAsset(symbol: "CHSB"),
                               makeAsset(symbol: "LINK")]

        let tickers: [Ticker] = [makeTicker(symbol: "tBTCUSD"),
                                 makeTicker(symbol: "tETHUSD"),
                                 makeTicker(symbol: "tCHSB:USD"),
                                 makeTicker(symbol: "tLINK:USD")]

        let array = CryptoMapper.cryptoArray(assets: assets, tickers: tickers)

        let expectedArray: [Crypto] = [.init(asset: makeAsset(symbol: "BTC"), ticker: makeTicker(symbol: "tBTCUSD")),
                                       .init(asset: makeAsset(symbol: "ETH"), ticker: makeTicker(symbol: "tETHUSD")),
                                       .init(asset: makeAsset(symbol: "CHSB"), ticker: makeTicker(symbol: "tCHSB:USD")),
                                       .init(asset: makeAsset(symbol: "LINK"), ticker: makeTicker(symbol: "tLINK:USD"))]

        XCTAssertEqual(array, expectedArray)
    }

    func testCryptoArrayMappingAssetsAndTickersReceivingUSDTValues() {
        let assets: [Asset] = [makeAsset(symbol: "BTC"),
                               makeAsset(symbol: "ETH"),
                               makeAsset(symbol: "CHSB"),
                               makeAsset(symbol: "LINK")]

        let tickers: [Ticker] = [makeTicker(symbol: "tBTCUSD"),
                                 makeTicker(symbol: "tETHUSDT"),
                                 makeTicker(symbol: "tCHSB:USD"),
                                 makeTicker(symbol: "tLINK:USDT")]

        let array = CryptoMapper.cryptoArray(assets: assets, tickers: tickers)

        let expectedArray: [Crypto] = [.init(asset: makeAsset(symbol: "BTC"), ticker: makeTicker(symbol: "tBTCUSD")),
                                       .init(asset: makeAsset(symbol: "CHSB"), ticker: makeTicker(symbol: "tCHSB:USD"))]

        XCTAssertEqual(array, expectedArray)
    }
}

extension CryptoMapperTests {
    private func makeAsset(symbol: String) -> Asset {
        .init(id: "",
              rank: "",
              symbol: symbol,
              name: "",
              supply: "",
              maxSupply: nil,
              marketCapUsd: nil,
              volumeUsd24Hr: nil,
              priceUsd: nil,
              changePercent24Hr: nil,
              explorer: nil)
    }

    private func makeTicker(symbol: String) -> Ticker {
        .init(symbol: symbol,
              bid: 0,
              bidSize: 0,
              ask: 0,
              askSize: 0,
              dailyChange: 0,
              dailyChangeRelative: 0,
              lastPrice: 0,
              dailyVolume: 0,
              dailyHigh: 0,
              dailyLow: 0)
    }
}
