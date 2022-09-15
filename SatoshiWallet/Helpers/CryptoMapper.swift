//
//  CryptoMapper.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 12/09/22.
//

import Foundation

final class CryptoMapper {
    // MARK: Properties
    static let twoDotsTickerList = ["CHSB", "AAVE", "LINK", "MATIC"]

    // MARK: Methods
    static func formattedTicker(of symbol: String) -> String {
        var ticker = "t\(symbol.uppercased())"
        let shouldAddTwoDots = twoDotsTickerList.contains(symbol) || symbol.count >= 4
        if shouldAddTwoDots {
            ticker += ":"
        }
        ticker += "USD"
        return ticker
    }

    static func tickerArray(from assets: [Asset]) -> [String] {
        var tickerArray: [String] = []

        assets.forEach { asset in
            tickerArray.append(formattedTicker(of: asset.symbol))
        }

        return tickerArray
    }

    static func cryptoArray(assets: [Asset], tickers: [Ticker]) -> [Crypto] {
        var cryptos: [Crypto] = []

        tickers.forEach { ticker in
            if let asset = assets.first(where: { self.formattedTicker(of: $0.symbol) == ticker.symbol }) {
                let crypto = Crypto(asset: asset, ticker: ticker)
                cryptos.append(crypto)
            }
        }

        return cryptos
    }
}
