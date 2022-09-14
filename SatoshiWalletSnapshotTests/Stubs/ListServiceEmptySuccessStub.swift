//
//  ListServiceEmptySuccessStub.swift
//  SatoshiWalletSnapshotTests
//
//  Created by Pedro Gabriel on 14/09/22.
//

import Foundation
@testable import SatoshiWallet

class ListServicesEmptySuccessStub: ListServicesProtocol {
    func getCryptoList(limit: Int,
                       completion: @escaping ((Result<[Crypto], NetworkError>) -> Void)) {
        let cryptos: [Crypto] = []
        completion(.success(cryptos))
    }

    func getAssetList(limit: Int,
                      completion: @escaping ((Result<ListResponse, NetworkError>) -> Void)) {
        completion(.success(.init(data: [], timestamp: 1)))
    }

    func getTickerList(tickers: [String],
                       completion: @escaping ((Result<[Ticker], NetworkError>) -> Void)) {
        completion(.success([]))
    }
}
