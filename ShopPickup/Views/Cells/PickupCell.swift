//
//  PickupCell.swift
//  ShopPickup
//
//  Created by Thanathip on 5/10/2563 BE.
//

import UIKit

final class PickupCell: UITableViewCell {
    public static let identifier = "pickupTableViewCell"
    
    @IBOutlet weak var radioImage: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var shopType: UILabel!
    @IBOutlet weak var distanceDetail: UILabel!
    
    func configWith() {
        // config data detail
    }
}
