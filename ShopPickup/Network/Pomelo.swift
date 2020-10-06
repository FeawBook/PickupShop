//
//  Polemo.swift
//  ShopPickup
//
//  Created by Thanathip on 5/10/2563 BE.
//

import Foundation
import Moya

enum Pomelo {
    case pickup
}

extension Pomelo: TargetType {
    var baseURL: URL {
        return URL(string: "https://api-staging.pmlo.co/v3")!
    }
    
    var path: String {
        switch self {
        case .pickup:
            return "/pickup-locations"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .pickup:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .pickup:
            return .requestParameters(
                parameters: [
                    "shop_id" : 1
                ],
                encoding: URLEncoding.default
            )
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .pickup:
            return ["content-type": "application/json"]
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
}


