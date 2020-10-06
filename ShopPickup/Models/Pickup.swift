//
//  Pickup.swift
//  ShopPickup
//
//  Created by Thanathip on 5/10/2563 BE.
//

import Foundation

struct Pickup: Codable {
    let alias: String
    let address1: String
    let city: String
    let latitude: Float?
    let longitude: Float?
    let type: String
}
