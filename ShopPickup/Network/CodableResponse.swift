//
//  CodableResponse.swift
//  ShopPickup
//
//  Created by Thanathip on 5/10/2563 BE.
//

import Foundation

struct PickupResponse<T: Codable>: Codable {
    let data: PickupResult<T>
}

struct PickupResult<T: Codable>: Codable {
    let pickup: [T]
}


