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
        crypto.imageUrl()
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
        crypto.priceFormatted()
    }

    func isChangePercentPositive() -> Bool {
        crypto.isChangePercentPositive()
    }

    func variation() -> String? {
        crypto.variationFormatted()
    }
}
