//
//  PickupViewController.swift
//  ShopPickup
//
//  Created by Thanathip on 5/10/2563 BE.
//

import UIKit

class PickupViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension PickupViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PickupCell.identifier, for: indexPath) as? PickupCell ?? PickupCell()
        return cell
    }
    
    
}
