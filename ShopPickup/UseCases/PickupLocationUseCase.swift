//
//  PickupLocationUseCase.swift
//  ShopPickup
//
//  Created by Thanathip on 5/10/2563 BE.
//

import Foundation

protocol PickupLocationUseCase {
    func pickupLocationShop(completionHandler: ResponsePickup)
}

final class PickupLocationUseCaseImpl: PickupLocationUseCase {
    
    private var pickupLocationRepository: PickupLocationRepositoty
    
    init(_ repository: PickupLocationRepositoty = PickupLocationRepositoryImpl()) {
        self.pickupLocationRepository = repository
    }
    
    func pickupLocationShop(completionHandler: ResponsePickup) {
        self.pickupLocationRepository.pickupLocation(completionHandler: completionHandler)
    }
    
    
}
