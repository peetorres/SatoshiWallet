//
//  ListServices.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 08/09/22.
//

import Foundation
import Moya

protocol ListServicesProtocol {
    func getAssetList(completion: @escaping ((Result<ListResponse, NetworkLayerError>) -> Void))
    func getTickerList(tickers: [String], completion: @escaping ((Result<[Ticker], NetworkLayerError>) -> Void))
}

final class ListServices: ListServicesProtocol {
    // MARK: Properties
    private let coinCapProvider = MoyaProvider<CoinCapAPI>()
    private let bitfinexProvider = MoyaProvider<BitfinexAPI>(plugins: [VerbosePlugin(verbose: true)])

    // MARK: Methods
    func getAssetList(completion: @escaping ((Result<ListResponse, NetworkLayerError>) -> Void)) {
        coinCapProvider.request(.assets) { result in
            switch result {
            case .success(let response):
                do {
                    let model = try response.map(ListResponse.self)
                    completion(.success(model))
                } catch {
                    completion(.failure(.parse(response.data)))
                }
            case .failure:
                completion(.failure(.unknown))
            }
        }
    }

    func getTickerList(tickers: [String], completion: @escaping ((Result<[Ticker], NetworkLayerError>) -> Void)) {
        bitfinexProvider.request(.tickers(symbols: tickers)) { result in
            switch result {
            case .success(let response):
                do {
                    let model = try response.map([Ticker].self)
                    completion(.success(model))
                } catch {
                    completion(.failure(.parse(response.data)))
                }
            case .failure:
                completion(.failure(.unknown))
            }
        }
    }
}
