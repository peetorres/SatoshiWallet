//
//  Network.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 08/09/22.
//

import Foundation
import Moya

public enum CoinCap {
    case assets
}

extension CoinCap: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.coincap.io/v2")!
    }

    public var path: String {
        switch self {
        case .assets: return "/assets"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .assets: return .get
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
