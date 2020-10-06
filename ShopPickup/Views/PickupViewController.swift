//
//  PickupViewController.swift
//  ShopPickup
//
//  Created by Thanathip on 5/10/2563 BE.
//

import UIKit
import MapKit
import CoreLocation

class PickupViewController: UIViewController {
    
    @IBOutlet private weak var loadingView: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var errorView: UIView!
    fileprivate let locationManager: CLLocationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    
    private var state: State = .loading {
        didSet {
            switch state {
            case .loading:
                self.loadingView.startAnimating()
                self.tableView.isHidden = true
                self.errorView.isHidden = true
            case .success:
                self.loadingView.stopAnimating()
                self.loadingView.isHidden = true
                self.errorView.isHidden = true
                self.tableView.isHidden = false
            case .error:
                self.loadingView.stopAnimating()
                self.loadingView.isHidden = true
                self.errorView.isHidden = false
                self.tableView.isHidden = true
            }
        }
    }
    
    private var viewModel: PickupViewModel! {
        didSet {
            bindViewModel()
        }
    }
    
    private func configuration(viewModel: PickupViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let setupViewModel = PickupViewModel()
        configuration(viewModel: setupViewModel)
        self.state = .loading
        self.viewModel.input.getPickupLocationData()
    }
    
    private func bindViewModel() {
        self.viewModel.output.didGetPickupLocationSuccess = pickupLocationSuccess
        self.viewModel.output.didGetPickupLocationSortSuccess = pickupLocationSortSuccess
        self.viewModel.output.didGetPickupLocationError = pickupLocationError
        self.viewModel.output.didGetPickupLocationSortError = pickupLocationError
    }
    
    func pickupLocationSuccess(items: [Pickup]) {
        self.state = .success(items)
        self.tableView.reloadData()
    }
    
    func pickupLocationSortSuccess(items: [Pickup]) {
        self.state = .success(items.sorted(by: { (data1, data2) -> Bool in
            CLLocation(latitude: CLLocationDegrees(data1.latitude ?? 0.0), longitude: CLLocationDegrees(data1.longitude ?? 0.0)).distance(from: self.currentLocation ?? CLLocation()) < CLLocation(latitude: CLLocationDegrees(data2.latitude ?? 0.0), longitude: CLLocationDegrees(data2.longitude ?? 0.0)).distance(from: self.currentLocation ?? CLLocation())
        }))
        self.tableView.reloadData()
    }
    
    func pickupLocationError(error: Error) {
        self.state = .error
        self.tableView.reloadData()
    }
    
    @IBAction func sortDistance(_ sender: Any) {
        self.getCurrentLocation()
    }
}

extension PickupViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard case .success(let items) = state else { return 0 }
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PickupCell.identifier, for: indexPath) as? PickupCell ?? PickupCell()
        guard case .success(let items) = state else { return cell }
        cell.configWith(pickup: items[indexPath.row],currentLocation: self.currentLocation)
        return cell
    }
    
    
}

extension PickupViewController {
    enum State {
        case loading
        case success([Pickup])
        case error
    }
}

extension PickupViewController: CLLocationManagerDelegate {
    private func getCurrentLocation() {
        self.locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.showsBackgroundLocationIndicator = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
        // Display the map using the default location.
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        @unknown default:
            fatalError()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.currentLocation = location
        locationManager.stopUpdatingLocation()
        self.viewModel.input.getPickupWithSort()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        alertError(error)
    }
    
    private func alertError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
