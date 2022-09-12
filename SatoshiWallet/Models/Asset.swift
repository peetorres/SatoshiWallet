//
//  Asset.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 07/09/22.
//

import Foundation

struct ListResponse: Decodable {
    let data: [Asset]
    let timestamp: Int
}

struct Asset: Decodable {
    let id: String
    let rank: String
    let symbol: String
    let name: String
    let supply: String
    let maxSupply: String?
    let marketCapUsd: String?
    let volumeUsd24Hr: String?
    let priceUsd: String?
    let changePercent24Hr: String?
    let explorer: String?
}
