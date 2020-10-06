//
//  PickupLocationRepository.swift
//  ShopPickup
//
//  Created by Thanathip on 5/10/2563 BE.
//

import Foundation
import Moya

typealias ResponsePickup = (([Pickup]?, Error?) -> Void)?
protocol PickupLocationRepositoty {
    func pickupLocation(completionHandler: ResponsePickup)
}

final class PickupLocationRepositoryImpl: PickupLocationRepositoty {
    func pickupLocation(completionHandler: ResponsePickup) {
        let provider = MoyaProvider<Pomelo>()
        provider.request(.pickup, completion: { result in
            switch result {
            case .success(let response):
                do {
                    let responseData = try response.map(PickupResponse<Pickup>.self).pickup
                    completionHandler?(responseData, nil)
                } catch(let error) {
                    completionHandler?(nil, error)
                }
            case .failure(let error):
                completionHandler?(nil, error)
            }
        })
    }
}
