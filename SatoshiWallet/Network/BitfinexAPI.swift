//
//  BitfinexAPI.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 12/09/22.
//

import Foundation
import Moya

public enum BitfinexAPI {
    case tickers(symbols: [String])
}

extension BitfinexAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api-pub.bitfinex.com/v2")!
    }

    public var path: String {
        switch self {
        case .tickers: return "/tickers"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .tickers: return .get
        }
    }

    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        switch self {
        case .tickers(let symbols):
            let parameters = symbols.joined(separator: ",")
            return .requestParameters(parameters: ["symbols": parameters], encoding: URLEncoding.queryString)
        }
    }

    public var headers: [String: String]? {
        return ["ContentType": "application/json"]
    }

    public var validationType: ValidationType {
        return .successCodes
    }
}
