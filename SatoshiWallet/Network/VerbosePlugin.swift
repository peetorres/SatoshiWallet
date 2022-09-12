//
//  VerbosePlugin.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 12/09/22.
//

import Foundation
import Moya

struct VerbosePlugin: PluginType {
    let verbose: Bool

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        #if DEBUG
        if let body = request.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            if verbose {
                print("Request to send: \(bodyString))")
            }
        }
        #endif
        return request
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        #if DEBUG
        switch result {
            case .success(let body):
                if verbose {
                    print("Response:")
                    if let json = try? JSONSerialization.jsonObject(with: body.data, options: .mutableContainers) {
                        print(json)
                    } else {
                        let response = String(data: body.data, encoding: .utf8)!
                        print(response)
                    }
                }
            case .failure: break
        }
        #endif
    }
}
