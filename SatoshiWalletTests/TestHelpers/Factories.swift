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
    static func makeCrypto(symbol: String) -> Crypto {
        Crypto(asset: makeAsset(symbol: symbol),
               ticker: makeTicker(symbol: CryptoMapper.formattedTicker(of: symbol)))
    }

    static func makeAsset(symbol: String) -> Asset {
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

   static func makeTicker(symbol: String) -> Ticker {
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
#endif
