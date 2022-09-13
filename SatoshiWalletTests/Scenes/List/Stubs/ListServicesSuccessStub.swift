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
        let cryptos: [Crypto] = [Crypto.makeCrypto(symbol: "BTC"),
                                 Crypto.makeCrypto(symbol: "ETH"),
                                 Crypto.makeCrypto(symbol: "CHSB"),
                                 Crypto.makeCrypto(symbol: "LINK")]
        completion(.success(cryptos))
    }
}
