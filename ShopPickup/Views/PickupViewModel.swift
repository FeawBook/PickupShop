//
//  PickupViewModel.swift
//  ShopPickup
//
//  Created by Thanathip on 5/10/2563 BE.
//

import Foundation

protocol PickupInputProtocol {
    func getPickupLocationData()
    func getPickupWithSort()
}

protocol PickupOutputProtocol: class {
    var didGetPickupLocationSuccess: (([Pickup]) -> Void)? { get set }
    var didGetPickupLocationError: ((Error) -> Void)? { get set }
    var didGetPickupLocationSortSuccess: (([Pickup]) -> Void)? { get set }
    var didGetPickupLocationSortError: ((Error) -> Void)? { get set }
}

protocol PickupProtocol: PickupInputProtocol, PickupOutputProtocol {
    var input: PickupInputProtocol { get }
    var output: PickupOutputProtocol { get }
}

class PickupViewModel: PickupProtocol {
    var input: PickupInputProtocol { return self }
    
    var output: PickupOutputProtocol { return self }
    
    var didGetPickupLocationSuccess: (([Pickup]) -> Void)?
    
    var didGetPickupLocationError: ((Error) -> Void)?
    
    var didGetPickupLocationSortSuccess: (([Pickup]) -> Void)?
    
    var didGetPickupLocationSortError: ((Error) -> Void)?
    
    var showLoading: (() -> Void)?
    
    var hiddenLoading: (() -> Void)?
    
    let pickupLocationUseCase: PickupLocationUseCase = PickupLocationUseCaseImpl()
    
    func getPickupLocationData() {
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
        }
    }
    
    func getPickupWithSort() {
        pickupLocationUseCase.pickupLocationShop { [weak self] (response, error)  in
            guard let self = self else { return }
            if error == nil {
                guard let pickup = response else {
                    return
                }
                self.didGetPickupLocationSortSuccess?(pickup)
            } else {
                guard let errorResp = error else {
                    return
                }
                self.didGetPickupLocationSortError?(errorResp)
            }
        }
    }
}
