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
        .makeCrypto(rank: "1",
                    symbol: "BTC",
                    name: "Bitcoin",
                    supply: "19149925.0000000000000000",
                    maxSupply: "21000000.0000000000000000",
                    explorer: "https://blockchain.info/",
                    dailyChangeRelative: -0.106,
                    lastPrice: 20104)
    }

    static func makeETH() -> Crypto {
        .makeCrypto(rank: "2",
                    symbol: "ETH",
                    name: "Ethereum",
                    supply: "122355980.9365000000000000",
                    maxSupply: nil,
                    explorer: "https://etherscan.io/",
                    dailyChangeRelative: -0.0758,
                    lastPrice: 1588.8)
    }

    static func makeCHSB() -> Crypto {
        .makeCrypto(rank: "100",
                    symbol: "CHSB",
                    name: "SwissBorg",
                    supply: "1000000000.0000000000000000",
                    maxSupply: nil,
                    explorer: "https://etherscan.io/token/0xba9d4199fab4f26efe3551d490e3821486f135ba",
                    dailyChangeRelative: 0.10,
                    lastPrice: 0.23)
    }

    static func makeDUMMY() -> Crypto {
        .makeCrypto(rank: "100000",
                    symbol: "DUMMY",
                    name: "DUMMY TEST",
                    supply: "1000000000000000000.0000000000000000",
                    maxSupply: nil,
                    explorer: nil,
                    dailyChangeRelative: 0.0000010,
                    lastPrice: 0.0023)
    }

    static func makeCrypto(rank: String = "",
                           symbol: String,
                           name: String,
                           supply: String = "",
                           maxSupply: String? = nil,
                           explorer: String? = nil,
                           dailyChangeRelative: Float = 0,
                           lastPrice: Float = 0) -> Crypto {
        Crypto(asset: makeAsset(rank: rank,
                                symbol: symbol,
                                name: name,
                                supply: supply,
                                maxSupply: maxSupply,
                                explorer: explorer),
               ticker: makeTicker(symbol: CryptoMapper.formattedTicker(of: symbol),
                                  dailyChangeRelative: dailyChangeRelative,
                                  lastPrice: lastPrice))
    }

    static func makeAsset(rank: String = "",
                          symbol: String,
                          name: String = "",
                          supply: String = "",
                          maxSupply: String? = "",
                          explorer: String? = "") -> Asset {
       .init(id: "",
             rank: rank,
             symbol: symbol,
             name: name,
             supply: supply,
             maxSupply: maxSupply,
             marketCapUsd: nil,
             volumeUsd24Hr: nil,
             priceUsd: nil,
             changePercent24Hr: nil,
             explorer: explorer)
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
