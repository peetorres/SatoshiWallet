//
//  Tickers.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 12/09/22.
//

import Foundation

struct Ticker: Codable {
    let symbol: String
    let dailyChange: Double
    let dailyChangeRelative: Double
    let lastPrice: Double
    let dailyVolume: Double
    let dailyHigh: Double
    let dailyLow: Double
}
