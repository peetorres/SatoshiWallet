//
//  NetworkError.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 13/09/22.
//

import Foundation
import Moya

public enum NetworkError: Error {
    case parse(Data?)
    case client(_ data: Data?, _ error: Error?, _ statusCode: Int)
    case server(_ data: Data?, _ error: Error?, _ statusCode: Int)
    case unknown

    init(data: Data?, response: HTTPURLResponse?, error: Error?) {
        self = .unknown
        if let httpResponse = response {
            switch httpResponse.statusCode {
            case 400...499:
                self = .client(data, error, httpResponse.statusCode)
            case 500...599:
                self = .server(data, error, httpResponse.statusCode)
            default:
                self = .unknown
            }
        }
    }
}

extension Error {
    func mapToNetworkError(with data: Data?) -> NetworkError {
        return .parse(data)
    }
}

extension MoyaError {
    func mapToNetworkError() -> NetworkError {
        let response = self.response?.response
        let data = self.response?.data
        let error = self
        return .init(data: data, response: response, error: error)
    }
}
