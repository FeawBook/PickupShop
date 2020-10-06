//
//  PickupCell.swift
//  ShopPickup
//
//  Created by Thanathip on 5/10/2563 BE.
//

import UIKit
import CoreLocation

final class PickupCell: UITableViewCell {
    public static let identifier = "pickupTableViewCell"
    
    @IBOutlet private weak var radioImage: UIImageView!
    @IBOutlet private weak var placeName: UILabel!
    @IBOutlet private weak var shopType: UILabel!
    @IBOutlet private weak var distanceDetail: UILabel!
    @IBOutlet private weak var shopName: UILabel!
    
    func configWith(pickup: Pickup, currentLocation: CLLocation?) {
        // config data detail
        self.placeName.text = pickup.address1
        self.shopType.text = pickup.type
        self.shopName.text = pickup.alias
        // set distance data
        guard let location = currentLocation else {
            self.distanceDetail.text = ""
            return
        }
        if pickup.latitude == 0.0 {
            self.distanceDetail.text = "N/A km"
        } else {
            let coordinate = CLLocation(latitude: CLLocationDegrees(pickup.latitude ?? 0.0), longitude: CLLocationDegrees(pickup.longitude ?? 0.0))
            let distanceMeter = coordinate.distance(from: location)
            self.distanceDetail.text = "\(Int(distanceMeter) / 1000) km"
        }
    }
}
