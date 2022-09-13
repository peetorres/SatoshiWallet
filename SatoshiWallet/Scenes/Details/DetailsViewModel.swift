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

    // MARK: View Formatting
    func imageUrl() -> URL? {
        crypto.imageUrl()
    }

    func rank() -> String {
        "#" + crypto.rank
    }

    func symbol() -> String {
        crypto.symbol
    }

    func name() -> String {
        crypto.name
    }

    func price() -> String? {
        crypto.priceFormatted()
    }

    func isChangePercentPositive() -> Bool {
        crypto.isChangePercentPositive()
    }

    func variation() -> String? {
        crypto.variationFormatted()
    }

    func maxSupply() -> String? {
        guard let maxSupply = crypto.maxSupplyFormatted() else {
            return nil
        }
        return "Max Supply: " + maxSupply
    }

    func circulatingSupply() -> String? {
        return "Circulating Supply: " + crypto.circulatingSupplyFormatted()
    }

    func explorer() -> String? {
        guard let explorer = crypto.explorer else {
            return nil
        }
        return "Explorer: " + explorer
    }
}
