//
//  PassTimesViewController.swift
//  astronauts
//
//  Created by Akash kahalkar on 21/06/19.
//  Copyright © 2019 akash. All rights reserved.
//

import UIKit
import CoreLocation

class PassTimesViewController: BaseViewController {

    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var closeButtonOutlet: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var passTimeData: [ISSPassTime] = []
    var authorizationCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        checkAuthorizationForLocationService()
        //add close button
        closeButtonOutlet.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped)))
        closeButtonOutlet.getFancyButton()
        //setup tableview
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        //setup backgroundView
        let colors = FlatColors.DIMIGO.colors()
        view.addGradientLayer(colors: [colors[3], colors[0]], cornerRadius: 0)

    }
    
    private func checkAuthorizationForLocationService() {
        switch CLLocationManager.authorizationStatus() {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted, .denied:
            locationManager.delegate = nil
            break
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            break
        @unknown default:
            break
        }
    }
    
    private func UpdateCurrentLocationLabel(location: CLLocation) {
        let reverseGeoCode = RevereseGeocode(latitiude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        reverseGeoCode.getAddress {[weak self] (address) in
            
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if let currentLocation = address {
                    self.currentLocationLabel.text = "Your Location: \(currentLocation)"
                }
            }
        }
    }
    
    private func requestPassTimeData(location: CLLocation) {
        RequestManager.getPassTime(location: location) {[weak self] (passTimeRsponse) in
            
            guard let self = self else { return }

            DispatchQueue.main.async {
                switch passTimeRsponse.result.status {
                case .success:
                    self.passTimeData = passTimeRsponse.passes
                    self.tableView.reloadData()
                case .fail:
                    let errorMsg = passTimeRsponse.result.message ?? "Error while fetching data"
                    let alert = UIAlertController.init(title: "Error",
                                                       message: errorMsg,
                                                       preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

extension PassTimesViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            requestPassTimeData(location: location)
            UpdateCurrentLocationLabel(location: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        
        case .notDetermined:
            if authorizationCount < 3 {
                locationManager.requestWhenInUseAuthorization()
                authorizationCount += 1
            }
            break
            
        case .restricted, .denied:
            locationManager.delegate = nil
            break
        
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            break
        }
    }
}

extension PassTimesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "PassTimeCell", for: indexPath) as? PassTimeCell)!
        cell.backgroundColor = .clear
        cell.setupCell(data: passTimeData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? PassTimeCell {
            cell.colorTheCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passTimeData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
