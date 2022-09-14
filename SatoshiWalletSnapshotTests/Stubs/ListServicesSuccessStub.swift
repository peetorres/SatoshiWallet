//
//  ListServicesSuccessStub.swift
//  SatoshiWalletSnapshotTests
//
//  Created by Pedro Gabriel on 14/09/22.
//

import Foundation
@testable import SatoshiWallet

class ListServicesSuccessStub: ListServicesProtocol {
    func getCryptoList(limit: Int,
                       completion: @escaping ((Result<[Crypto], NetworkError>) -> Void)) {
        let cryptos: [Crypto] = [.makeBTC(),
                                 .makeETH(),
                                 .makeCHSB(),
                                 Crypto.makeCrypto(symbol: "LINK", name: "Chainlink"),
                                 Crypto.makeCrypto(symbol: "BSV", name: "Bitcoin SV")]
        completion(.success(cryptos))
    }

    func getAssetList(limit: Int,
                      completion: @escaping ((Result<ListResponse, NetworkError>) -> Void)) {
        completion(.success(.init(data: [Crypto.makeAsset(symbol: "BTC", name: "Bitcoin"),
                                         Crypto.makeAsset(symbol: "ETH", name: "Bitcoin"),
                                         Crypto.makeAsset(symbol: "CHSB", name: "Bitcoin"),
                                         Crypto.makeAsset(symbol: "LINK", name: "Bitcoin"),
                                         Crypto.makeAsset(symbol: "BSV", name: "Bitcoin")], timestamp: 1)))
    }

    func getTickerList(tickers: [String],
                       completion: @escaping ((Result<[Ticker], NetworkError>) -> Void)) {
        completion(.success([Crypto.makeTicker(symbol: CryptoMapper.formattedTicker(of: "BTC")),
                             Crypto.makeTicker(symbol: CryptoMapper.formattedTicker(of: "ETH")),
                             Crypto.makeTicker(symbol: CryptoMapper.formattedTicker(of: "CHSB")),
                             Crypto.makeTicker(symbol: CryptoMapper.formattedTicker(of: "LINK")),
                             Crypto.makeTicker(symbol: CryptoMapper.formattedTicker(of: "BSV"))]))
    }
}
