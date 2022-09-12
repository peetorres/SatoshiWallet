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

extension Crypto {
    func imageUrl() -> URL? {
        let symbol = symbol.lowercased()
        return URL(string: "https://assets.coincap.io/assets/icons/\(symbol)@2x.png")
    }

    func priceFormatted() -> String? {
        "$" + String(price)
    }

    private func changePercentFormatted() -> Float? {
        changePercentDaily
    }

    func isChangePercentPositive() -> Bool {
        changePercentDaily >= 0
    }

    func variationFormatted() -> String? {
        guard let changePercent = changePercentFormatted() else { return nil }
        return String(format: "%.2f%%", changePercent)
    }

    func maxSupplyFormatted() -> String? {
        guard let maxSupply = maxSupply else { return nil }
        return String(format: "%.2f%", maxSupply)
    }

    func circulatingSupplyFormatted() -> String? {
        return String(format: "%.2f%", supply)
    }
}
