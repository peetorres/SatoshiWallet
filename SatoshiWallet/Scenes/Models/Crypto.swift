//
//  Crypto.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 12/09/22.
//

import Foundation

struct Crypto: Equatable {
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
        self.changePercentDaily = ticker.dailyChangeRelative
        self.explorer = asset.explorer
    }
}

extension Crypto {
    func imageUrl() -> URL? {
        CoinCapAPI.imageUrl(of: symbol)
    }

    func priceFormatted() -> String? {
        "$" + String(format: "%.2f%", price)
    }

    private func changePercentFormatted() -> Float {
        changePercentDaily * 100
    }

    func isChangePercentPositive() -> Bool {
        changePercentDaily >= 0
    }

    func variationFormatted() -> String {
        return String(format: "%.2f%%", changePercentFormatted())
    }

    func maxSupplyFormatted() -> String? {
        guard let maxSupply = maxSupply,
              let decimalMaxSupply = Decimal(string: maxSupply) else { return nil }
        return decimalMaxSupply.description
    }

    func circulatingSupplyFormatted() -> String {
        return Decimal(string: supply)?.description ?? "-"
    }
}
