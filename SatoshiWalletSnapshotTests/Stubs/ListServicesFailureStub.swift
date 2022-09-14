//
//  ListServicesFailureStub.swift
//  SatoshiWalletSnapshotTests
//
//  Created by Pedro Gabriel on 14/09/22.
//

import Foundation
@testable import SatoshiWallet

class ListServicesFailureStub: ListServicesProtocol {
    func getCryptoList(limit: Int,
                       completion: @escaping ((Result<[Crypto], NetworkError>) -> Void)) {
        completion(.failure(.unknown))
    }

    func getAssetList(limit: Int,
                      completion: @escaping ((Result<ListResponse, NetworkError>) -> Void)) {
        completion(.failure(.unknown))
    }

    func getTickerList(tickers: [String],
                       completion: @escaping ((Result<[Ticker], NetworkError>) -> Void)) {
        completion(.failure(.unknown))
    }
}
