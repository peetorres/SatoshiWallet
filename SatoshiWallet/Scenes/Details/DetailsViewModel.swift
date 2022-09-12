//
//  DetailsViewModel.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 08/09/22.
//

import Foundation

final class DetailsViewModel {
    // MARK: Properties
    var crypto: Crypto

    // MARK: Initializer
    init(crypto: Crypto) {
        self.crypto = crypto
    }

    // MARK: ViewModel Formatting
    func imageUrl() -> URL? {
        let symbol = crypto.symbol.lowercased()
        return URL(string: "https://assets.coincap.io/assets/icons/\(symbol)@2x.png")
    }

    func rankText() -> String {
        "#" + crypto.rank
    }

    func symbolText() -> String {
        crypto.symbol
    }

    func nameText() -> String {
        crypto.name
    }

    func priceText() -> String? {
        String(crypto.price)
    }

    func changePercent() -> Float? {
        crypto.changePercentDaily
    }

    func isChangePercentPositive() -> Bool {
        return crypto.changePercentDaily >= 0
    }

    func variationText() -> String? {
        guard let changePercent = changePercent() else { return nil }
        return String(format: "%.2f%%", changePercent)
    }

    func marketcapText() -> String? {
        nil
    }

    func volumeDayText() -> String? {
        nil
    }

    func maxSupplyText() -> String? {
        guard let maxSupply = crypto.maxSupply else {
            return nil
        }
        return "Max Supply: " + maxSupply
    }

    func circulatingSupplyText() -> String? {
        "Circulating Supply: " + crypto.supply
    }

    func explorerText() -> String? {
        guard let explorer = crypto.explorer else {
            return nil
        }
        return "Explorer: " + explorer
    }
}
