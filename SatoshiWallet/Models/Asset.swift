//
//  Asset.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 07/09/22.
//

import Foundation

struct ListResponse: Codable {
    let data: [Asset]
    let timestamp: Int
}

struct Asset: Codable {
    let id: String
    let rank: String
    let symbol: String
    let name: String
    let supply: String
    let maxSupply: String?
    let marketCapUsd: String?
    let priceUsd: String?
    let changePercet24Hr: String?
}
