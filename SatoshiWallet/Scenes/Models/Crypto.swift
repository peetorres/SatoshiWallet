//
//  Crypto.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 12/09/22.
//

import Foundation

struct Crypto {
    let id: String
    let name: String
    let rank: String
    let symbol: String
    let supply: String
    let maxSupply: String?
    let price: Float
    let changePercentDaily: Float
    let explorer: String?

    init(asset: Asset, ticker: Ticker) {
        self.id = asset.id
        self.name = asset.name
        self.rank = asset.rank
        self.symbol = asset.symbol
        self.supply = asset.supply
        self.maxSupply = asset.maxSupply
        self.price = ticker.lastPrice
        self.changePercentDaily = ticker.dailyChange
        self.explorer = asset.explorer
    }
}
