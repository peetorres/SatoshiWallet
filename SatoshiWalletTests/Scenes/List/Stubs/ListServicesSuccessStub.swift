//
//  ListServicesSuccessStub.swift
//  SatoshiWalletTests
//
//  Created by Pedro Gabriel on 13/09/22.
//

import Foundation
@testable import SatoshiWallet

class ListServicesSuccessStub: ListServicesProtocol {
    func getCryptoList(limit: Int,
                       completion: @escaping ((Result<[Crypto], NetworkError>) -> Void)) {
        let cryptos: [Crypto] = [Crypto.makeCrypto(symbol: "BTC", name: "Bitcoin"),
                                 Crypto.makeCrypto(symbol: "ETH", name: "Ethereum"),
                                 Crypto.makeCrypto(symbol: "CHSB", name: "SwissBorg"),
                                 Crypto.makeCrypto(symbol: "LINK", name: "Chainlink"),
                                 Crypto.makeCrypto(symbol: "BSV", name: "Bitcoin SV")]
        completion(.success(cryptos))
    }
}
