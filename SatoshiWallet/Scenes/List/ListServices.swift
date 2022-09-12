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
}

final class ListServices: ListServicesProtocol {
    // MARK: Properties
    private let provider = MoyaProvider<CoinCapAPI>()

    // MARK: Methods
    func getAssetList(completion: @escaping ((Result<ListResponse, NetworkLayerError>) -> Void)) {
        provider.request(.assets) { result in
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
}
