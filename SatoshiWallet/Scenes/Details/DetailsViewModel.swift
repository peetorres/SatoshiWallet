//
//  DetailsViewModel.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 08/09/22.
//

import Foundation

final class DetailsViewModel {
    // MARK: Properties
    var asset: Asset

    // MARK: Initializer
    init(asset: Asset) {
        self.asset = asset
    }
}

// MARK: ViewModel Formatting
extension DetailsViewModel {
    func imageUrl() -> URL? {
        let symbol = asset.symbol.lowercased()
        return URL(string: "https://assets.coincap.io/assets/icons/\(symbol)@2x.png")
    }

    func rankText() -> String {
        "#" + asset.rank
    }

    func symbolText() -> String {
        asset.symbol
    }

    func nameText() -> String {
        asset.name
    }

    func priceText() -> String? {
        asset.priceUsd?.currencyFormatting()
    }

    func changePercent() -> Double? {
        guard let changePercentString = asset.changePercent24Hr,
              let changePercent = Double(changePercentString) else {
            return nil
        }
        return changePercent
    }

    func isChangePercentPositive() -> Bool {
        guard let changePercentString = asset.changePercent24Hr,
              let changePercent = Double(changePercentString) else {
            return false
        }
        return changePercent >= 0
    }

    func variationText() -> String? {
        guard let changePercent = changePercent() else { return nil }
        return String(format: "%.2f%%", changePercent)
    }

    func marketcapText() -> String? {
        guard let marketcap = asset.marketCapUsd?.currencyFormatting() else {
            return nil
        }
        return "Marketcap: " + marketcap
    }

    func volumeDayText() -> String? {
        guard let volumeUsd24Hr = asset.volumeUsd24Hr?.currencyFormatting() else {
            return nil
        }
        return "Volume 24h: " + volumeUsd24Hr
    }

    func maxSupplyText() -> String? {
        guard let maxSupply = asset.maxSupply else {
            return nil
        }
        return "Max Supply: " + maxSupply
    }

    func circulatingSupplyText() -> String? {
        "Circulating Supply: " + asset.supply
    }

    func explorerText() -> String? {
        guard let explorer = asset.explorer else {
            return nil
        }
        return "Explorer: " + explorer
    }
}
