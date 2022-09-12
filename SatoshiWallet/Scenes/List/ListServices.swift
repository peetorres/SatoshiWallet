//
//  ListServices.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 08/09/22.
//

import Foundation
import Moya

protocol ListServicesProtocol {
    func getCryptoList(limit: Int, completion: @escaping ((Result<[Crypto], NetworkLayerError>) -> Void))
    func getAssetList(limit: Int, completion: @escaping ((Result<ListResponse, NetworkLayerError>) -> Void))
    func getTickerList(tickers: [String], completion: @escaping ((Result<[Ticker], NetworkLayerError>) -> Void))
}

final class ListServices: ListServicesProtocol {
    // MARK: Properties
    private let coinCapProvider = MoyaProvider<CoinCapAPI>()
    private let bitfinexProvider = MoyaProvider<BitfinexAPI>()

    // MARK: Services
    func getCryptoList(limit: Int, completion: @escaping ((Result<[Crypto], NetworkLayerError>) -> Void)) {
        getAssetList(limit: limit) { [weak self] response in
            guard let self = self else { return }

            switch response {
            case .success(let assetList):

                let assets = assetList.data
                let searchTickers = CryptoMapper.tickerArray(from: assets)

                self.getTickerList(tickers: searchTickers) { response in
                    switch response {
                    case .success(let tickers):

                        let cryptoList = CryptoMapper.cryptoArray(assets: assets, tickers: tickers)
                        completion(.success(cryptoList))

                    case .failure:
                        completion(.failure(.unknown))
                    }
                }

            case .failure:
                completion(.failure(.unknown))
            }
        }
    }

    func getAssetList(limit: Int, completion: @escaping ((Result<ListResponse, NetworkLayerError>) -> Void)) {
        coinCapProvider.request(.assets(limit: limit)) { result in
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
