//
//  Factories.swift
//  SatoshiWalletTests
//
//  Created by Pedro Gabriel on 13/09/22.
//

import Foundation
@testable import SatoshiWallet

#if DEBUG
extension Crypto {
    static func makeBTC() -> Crypto {
        .makeCrypto(rank: "1", symbol: "BTC", name: "Bitcoin", dailyChangeRelative: -0.106, lastPrice: 20104)
    }

    static func makeETH() -> Crypto {
        .makeCrypto(rank: "2", symbol: "ETH", name: "Ethereum", dailyChangeRelative: -0.0758, lastPrice: 1588.8)
    }

    static func makeCHSB() -> Crypto {
        .makeCrypto(rank: "100", symbol: "CHSB", name: "SwissBorg", dailyChangeRelative: 0.10, lastPrice: 0.23)
    }

    static func makeCrypto(rank: String = "",
                           symbol: String,
                           name: String,
                           dailyChangeRelative: Float = 0,
                           lastPrice: Float = 0) -> Crypto {
        Crypto(asset: makeAsset(rank: rank, symbol: symbol, name: name),
               ticker: makeTicker(symbol: CryptoMapper.formattedTicker(of: symbol),
                                  dailyChangeRelative: dailyChangeRelative,
                                  lastPrice: lastPrice))
    }

    static func makeAsset(rank: String = "", symbol: String, name: String = "") -> Asset {
       .init(id: "",
             rank: rank,
             symbol: symbol,
             name: name,
             supply: "",
             maxSupply: nil,
             marketCapUsd: nil,
             volumeUsd24Hr: nil,
             priceUsd: nil,
             changePercent24Hr: nil,
             explorer: nil)
   }

    static func makeTicker(symbol: String, dailyChangeRelative: Float = 0, lastPrice: Float = 0) -> Ticker {
       .init(symbol: symbol,
             bid: 0,
             bidSize: 0,
             ask: 0,
             askSize: 0,
             dailyChange: 0,
             dailyChangeRelative: dailyChangeRelative,
             lastPrice: lastPrice,
             dailyVolume: 0,
             dailyHigh: 0,
             dailyLow: 0)
   }
}
#endif
