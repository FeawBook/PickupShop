//
//  PickupViewModel.swift
//  ShopPickup
//
//  Created by Thanathip on 5/10/2563 BE.
//

import Foundation

protocol PickupInputProtocol {
    func getPickupLocationData()
}

protocol PickupOutputProtocol {
    var didGetPickupLocationSuccess: (([Pickup]) -> Void)? { get set }
    var didGetPickupLocationError: ((Error) -> Void)? { get set }
    var showLoading: (() -> Void)? { get set }
    var hiddenLoading: (() -> Void)? { get set }
}

protocol PickupProtocol: PickupInputProtocol, PickupOutputProtocol {
    var input: PickupInputProtocol { get }
    var output: PickupOutputProtocol { get }
}

final class PickupViewModel: PickupProtocol {
    var input: PickupInputProtocol { return self }
    
    var output: PickupOutputProtocol { return self }
    
    var didGetPickupLocationSuccess: (([Pickup]) -> Void)?
    
    var didGetPickupLocationError: ((Error) -> Void)?
    
    var showLoading: (() -> Void)?
    
    var hiddenLoading: (() -> Void)?
    
    let pickupLocationUseCase: PickupLocationUseCase = PickupLocationUseCaseImpl()
    
    func getPickupLocationData() {
        self.showLoading?()
        pickupLocationUseCase.pickupLocationShop { [weak self] (response, error)  in
            guard let self = self else { return }
            if error == nil {
                guard let pickup = response else {
                    return
                }
                self.didGetPickupLocationSuccess?(pickup)
            } else {
                guard let errorResp = error else {
                    return
                }
                self.didGetPickupLocationError?(errorResp)
            }
            self.hiddenLoading?()
        }
    }
}
