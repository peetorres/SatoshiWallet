//
//  Tickers.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 12/09/22.
//

import Foundation

struct Ticker: Decodable {
    // MARK: Properties
    let symbol: String
    let dailyChange: Float
    let dailyChangeRelative: Float
    let lastPrice: Float
    let dailyVolume: Float?
    let dailyHigh: Float?
    let dailyLow: Float?

    // MARK: Initializer
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()

        symbol = try container.decode(String.self)
        dailyChange = try container.decode(Float.self)
        dailyChangeRelative = try container.decode(Float.self)
        lastPrice = try container.decode(Float.self)
        dailyVolume = try container.decode(Float.self)
        dailyHigh = try container.decode(Float.self)
        dailyLow = try container.decode(Float.self)
    }
}
