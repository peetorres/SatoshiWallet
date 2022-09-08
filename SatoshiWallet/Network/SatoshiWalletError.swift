//
//  SatoshiWalletError.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 08/09/22.
//

import Foundation

public enum SatoshiWalletError: Error {
    case parse(Data?)
    case client(_ data: Data?, _ error: Error?, _ statusCode: Int)
    case server(_ data: Data?, _ error: Error?, _ statusCode: Int)
    case unknown

    init(data: Data?, _ response: URLResponse?, error: Error?) {
        self = .unknown
        if let httpResponse = response as? HTTPURLResponse {
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
