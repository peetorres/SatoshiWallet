//
//  ListCellViewModel.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 11/09/22.
//

import Foundation

final class ListCellViewModel {
    // MARK: Properties
    let crypto: Crypto

    // MARK: Initializer
    init(crypto: Crypto) {
        self.crypto = crypto
    }

    // MARK: View Formatting
    func imageUrl() -> URL? {
        let symbol = crypto.symbol.lowercased()
        return URL(string: "https://assets.coincap.io/assets/icons/\(symbol)@2x.png")
    }

    func rank() -> String {
        crypto.rank
    }

    func symbol() -> String {
        crypto.symbol
    }

    func name() -> String {
        crypto.name
    }

    func price() -> String? {
        String(crypto.price)
    }

    func changePercent() -> Float? {
        crypto.changePercentDaily
    }

    func isChangePercentPositive() -> Bool {
        return crypto.changePercentDaily >= 0
    }

    func variation() -> String? {
        guard let changePercent = changePercent() else { return nil }
        return String(format: "%.2f%%", changePercent)
    }
}
