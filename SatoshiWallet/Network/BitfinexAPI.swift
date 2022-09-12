//
//  BitfinexAPI.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 12/09/22.
//

import Foundation
import Moya

public enum BitfinexAPI {
    case tickers(String)
}

extension BitfinexAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api-pub.bitfinex.com/v2")!
    }

    public var path: String {
        switch self {
        case .tickers(let symbols): return "/tickers?\(symbols)"
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
        return .requestPlain
    }

    public var headers: [String: String]? {
        return ["ContentType": "application/json"]
    }

    public var validationType: ValidationType {
        return .successCodes
    }
}
