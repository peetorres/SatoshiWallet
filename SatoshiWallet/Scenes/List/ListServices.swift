//
//  ListServices.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 08/09/22.
//

import Foundation
import Moya

protocol ListServicesProtocol {
    func getCryptoList(limit: Int, completion: @escaping ((Result<[Crypto], NetworkError>) -> Void))
}

final class ListServices: ListServicesProtocol {
    // MARK: Properties
    private let coinCapProvider = MoyaProvider<CoinCapAPI>()
    private let bitfinexProvider = MoyaProvider<BitfinexAPI>()

    // MARK: Services
    func getCryptoList(limit: Int, completion: @escaping ((Result<[Crypto], NetworkError>) -> Void)) {
        getAssetList(limit: limit) { [weak self] response in
            guard let self = self else { return }

            switch response {
            case .success(let assetList):

                let assets = assetList.data
                let searchTickers = CryptoMapper.tickerArray(from: assets)

                self.getTickerList(tickers: searchTickers) { [weak self] response in
                    guard self != nil else { return }

                    switch response {
                    case .success(let tickers):

                        let cryptoList = CryptoMapper.cryptoArray(assets: assets, tickers: tickers)
                        completion(.success(cryptoList))

                    case .failure(let error):
                        completion(.failure(error.mapToNetworkError()))
                    }
                }

            case .failure(let error):
                    completion(.failure(error.mapToNetworkError()))
            }
        }
    }

    func getAssetList(limit: Int, completion: @escaping ((Result<ListResponse, MoyaError>) -> Void)) {
        coinCapProvider.request(.assets(limit: limit)) { [weak self] result in
            guard self != nil else { return }

            switch result {
            case .success(let response):
                do {
                    let model = try response.map(ListResponse.self)
                    completion(.success(model))
                } catch {
                    completion(.failure(.objectMapping(error, response)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getTickerList(tickers: [String], completion: @escaping ((Result<[Ticker], MoyaError>) -> Void)) {
        bitfinexProvider.request(.tickers(symbols: tickers)) { [weak self] result in
            guard self != nil else { return }

            switch result {
            case .success(let response):
                do {
                    let model = try response.map([Ticker].self)
                    completion(.success(model))
                } catch {
                    completion(.failure(.objectMapping(error, response)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
