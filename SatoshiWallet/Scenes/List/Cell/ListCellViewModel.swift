//
//  ListCellViewModel.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 11/09/22.
//

import Foundation

final class ListCellViewModel {
    // MARK: Properties
    let asset: Asset

    // MARK: Initializer
    init(asset: Asset) {
        self.asset = asset
    }

    // MARK: View Formatting
    func imageUrl() -> URL? {
        let symbol = asset.symbol.lowercased()
        return URL(string: "https://assets.coincap.io/assets/icons/\(symbol)@2x.png")
    }

    func rank() -> String {
        asset.rank
    }

    func symbol() -> String {
        asset.symbol
    }

    func name() -> String {
        asset.name
    }

    func price() -> String? {
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

    func variation() -> String? {
        guard let changePercent = changePercent() else { return nil }
        return String(format: "%.2f%%", changePercent)
    }
}
