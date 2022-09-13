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
    static func ==(lhs: Crypto, rhs: Crypto) -> Bool {
        return  lhs.id == rhs.id
                && lhs.name == rhs.name
                && lhs.rank == rhs.rank
                && lhs.symbol == rhs.symbol
                && lhs.supply == rhs.supply
                && lhs.maxSupply == rhs.maxSupply
                && lhs.price == rhs.price
                && lhs.changePercentDaily == rhs.changePercentDaily
                && lhs.explorer == rhs.explorer
    }
}

extension Crypto {
    func imageUrl() -> URL? {
        let symbol = symbol.lowercased()
        return URL(string: "https://assets.coincap.io/assets/icons/\(symbol)@2x.png")
    }

    func priceFormatted() -> String? {
        "$" + String(format: "%.2f%", price)
    }

    private func changePercentFormatted() -> Float? {
        changePercentDaily * 100
    }

    func isChangePercentPositive() -> Bool {
        changePercentDaily >= 0
    }

    func variationFormatted() -> String? {
        guard let changePercent = changePercentFormatted() else { return nil }
        return String(format: "%.2f%%", changePercent)
    }

    func maxSupplyFormatted() -> String? {
        guard let maxSupply = maxSupply,
              let decimalMaxSupply = Decimal(string: maxSupply) else { return nil }
        return decimalMaxSupply.description
    }

    func circulatingSupplyFormatted() -> String? {
        guard let decimalSupply = Decimal(string: supply) else { return nil }
        return decimalSupply.description
    }
}
