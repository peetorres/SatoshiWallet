//
//  ListServices.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 08/09/22.
//

import Foundation
import Moya
import RxSwift

protocol ListServicesProtocol {
    func getCryptoList(limit: Int, completion: @escaping ((Result<[Crypto], NetworkError>) -> Void))
}

final class ListServices: ListServicesProtocol {
    // MARK: Properties
    private let coinCapProvider = MoyaProvider<CoinCapAPI>()
    private let bitfinexProvider = MoyaProvider<BitfinexAPI>()
    private let bag = DisposeBag()

    // MARK: Services
    func getCryptoList(limit: Int, completion: @escaping ((Result<[Crypto], NetworkError>) -> Void)) {
        getAssetList(limit: limit)
            .flatMap { [weak self] assetList in
                guard let self = self else { return .error(NetworkError.unknown) }
                return self.getTickerList(assets: assetList)
            }
            .map { CryptoMapper.cryptoArray(assets: $0, tickers: $1) }
            .subscribe(onSuccess: { cryptos in
                completion(.success(cryptos))
            }, onFailure: { _ in
                completion(.failure(.unknown))
            })
            .disposed(by: bag)
    }

    private func getAssetList(limit: Int) -> Single<[Asset]> {
        coinCapProvider.rx.request(.assets(limit: limit))
            .flatMap { [weak self] in
                guard let self = self else { return .error(NetworkError.unknown) }
                return self.map(assetListResponse: $0)
            }
    }

    private func map(assetListResponse: Response) -> Single<[Asset]> {
        Single.create { single in
            do {
                let assetList = try assetListResponse.map(ListResponse.self, using: JSONDecoder())
                let assets = assetList.data
                single(.success(assets))
            } catch let error {
                single(.failure(error))
            }
            return Disposables.create()
        }
    }

    private func getTickerList(assets: [Asset]) -> Single<([Asset], [Ticker])> {
        let searchTickers = CryptoMapper.tickerArray(from: assets)
        return bitfinexProvider.rx.request(.tickers(symbols: searchTickers))
            .flatMap { [weak self] in
                guard let self = self else { return .error(NetworkError.unknown) }
                return self.map(tickerResponse: $0)
            }
            .map { (assets, $0) }
    }

    private func map(tickerResponse: Response) -> Single<[Ticker]> {
        Single.create { single in
            do {
                let tickers = try tickerResponse.map([Ticker].self, using: JSONDecoder())
                single(.success(tickers))
            } catch let error {
                single(.failure(error))
            }
            return Disposables.create()
        }
    }
}
